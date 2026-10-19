import { Controller, Get, Param } from '@nestjs/common';

@Controller('admin')
export class AdminController {
  @Get('users')
  getUsers() {
    return this.admin.getAllUsers();
  }

  @Get('users/:id')
  getUser(@Param('id') id: string) {
    return this.admin.getUser(id);
  }
}
