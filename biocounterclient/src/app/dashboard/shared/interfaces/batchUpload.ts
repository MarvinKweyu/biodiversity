export interface batchUpload {
    _id: string,
    name: string,
    description: string,
    region_name: string,
    is_active: boolean,
    operating_system_version: string,
    operating_system: string,
    region: string,
    backup_freq: string,
    disk_size: string,
    created: string,
    last_backup: string,
    history: [],
    backups: [],
    user_info: {id: number,
      name: string,
      email: string,
      role: string}
}


