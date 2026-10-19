import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private prisma: PrismaService,
    private jwt: JwtService,
  ) {}

  async login(email: string, password: string) {
    const user = await this.prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // ✔ Your schema uses passwordHash, NOT password
    const valid = await bcrypt.compare(password, user.passwordHash ?? '');

    if (!valid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // ✔ Your schema has NO organizationId
    // ✔ Your schema DOES have role, ownerId, id
    const token = this.jwt.sign({
      sub: user.id,
      role: user.role,
      ownerId: user.ownerId,
    });

    return {
      token,
      user,
    };
  }
}
