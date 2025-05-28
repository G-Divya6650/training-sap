using { training.cap.db as db } from '../db/schema';

service catalogService {
      entity Users as projection on db.Users;

      entity Users1 as projection on db.Users;
}