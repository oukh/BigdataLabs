package edu.supmti.hadoop;

import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.*;

public class WriteHDFS {

    public static void main(String[] args) throws IOException {

        if (args.length < 2) {
            System.out.println("Usage: WriteHDFS <path> <message>");
            System.exit(1);
        }

        Configuration conf = new Configuration();
        FileSystem fs = FileSystem.get(conf);

        Path path = new Path(args[0]);

        if (!fs.exists(path)) {
            FSDataOutputStream out = fs.create(path);
            out.writeUTF("Bonjour tout le monde !");
            out.writeUTF(args[1]);
            out.close();
        }

        fs.close();
    }
}
