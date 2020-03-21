Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E9518E22D
	for <lists+linux-can@lfdr.de>; Sat, 21 Mar 2020 15:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCUOuP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 21 Mar 2020 10:50:15 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:38140 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUOuP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2020 10:50:15 -0400
Received: by mail-lf1-f49.google.com with SMTP id c5so1305851lfp.5
        for <linux-can@vger.kernel.org>; Sat, 21 Mar 2020 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xOKKUoYluw+nqt9KxNlrCwZm/jCx6S0maTnbCVaHOXs=;
        b=pF48HoGvI/djBxzOWxAJmiBgEWBqW1ySIJ5ukLPUQMw6bMVfSjPQdFX7MrJndl+OXW
         5tZUizgPK8DlpnkctgyqEE6N9WW+9qIZbP8cPpghZ6jOEiaAye21+7wtJLmIg5t4l872
         aZrHwxd77y9KaLU+omtvU29mcuaPU+5ULRUrg8lsbsKmq3sAQdk3Xs7lQ3caX89nNpCu
         pQDTRkxbackUyOwWIM08npqDYeicc4+sBRAKDyYRbCbiio4nAFiYwxab1jfAuWDehxs2
         tF9cjwpRg3AsIb46hB79mZR4SEEmYG3eG2B04Oqn2xybv0eMAxEdZXzuahqvqxPpzXMK
         oWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xOKKUoYluw+nqt9KxNlrCwZm/jCx6S0maTnbCVaHOXs=;
        b=k/zu+ldF2lvYTByS9ZpPO5/KD0/dtny/avBPVI3pMM1buRJ716W/PZmVWBQmKk7f2S
         aY7Fo68eqVAyIPQAF0Yd0kyaYfjssFRqT6fbrNb2PnhdDpPY4IQFk6heXH6Bw6+YeBrG
         MD4k/+u+hdOu77XPW9N7bPF6vs+HIo4iwhapooj7BnEwEeEG7hMxuIx0GsKicVq8hcI7
         Uu7XlwqCxAAZxrsGVscdSL4oYcXxxKQb+EWioB+fFC+bqIC+0/plP0VJY9tOwLztWH+t
         BLBSizGcrkjtNwRplMuSGnoEYURKTiCnAP8a4Sso//pkqrEIPa1fX+ns+E9k6YV4Vsby
         uSvQ==
X-Gm-Message-State: ANhLgQ2YQ+ggiOxL22QTYfMOn38I+YTi7TcSM4bvDazJctarBV4Fbz6R
        tt3YZFPL8cqZnCPar7126kI4m/V6SRNT+05LmeHhKsxennY=
X-Google-Smtp-Source: ADFU+vvS/JryJhCX6sE7WKP2mmbdcAfCY36ubbGRy2Wn/As95b+SRH7pTyYyJuiNTgqRjf+t0+CtzqkMj+pBUE2v050=
X-Received: by 2002:a19:a409:: with SMTP id q9mr3742752lfc.71.1584802211803;
 Sat, 21 Mar 2020 07:50:11 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Barrows <robb.barrows@gmail.com>
Date:   Sat, 21 Mar 2020 09:50:00 -0500
Message-ID: <CAOHJ0jSS=g4rQtXGkEFocafEqQAtxEOvq5eSXBC2FY_Esb23OA@mail.gmail.com>
Subject: How to send a CAN message while in a kernel module?
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I have attempted to write a kernel module that sends a message via CAN but I am
having trouble understanding which level of the socket api I should be using,
and where there may be some documentation or examples of how to use it?

I am on a much older embedded 2.6.31 imx arm kernel, and eventually I
would like to
send this message from within a high res timer triggered ISR.

This is my code, which is hobbled together from internet examples, and kernel
oops is during sock_sendmsg, for now I am just trying to get it do run as part
of the init of the module:

int SendCanTime(struct timespec *tsCurrentTime) {
  int s;
  struct sockaddr_can addr;
  struct can_frame frame;
  struct socket *sock;
  int thetime = tsCurrentTime->tv_sec;
  mm_segment_t oldfs;

  oldfs = get_fs();
  set_fs(KERNEL_DS);

  printk("cantime.ko: Socket 10\n");
  if ((s = sock_create(PF_CAN, SOCK_RAW, CAN_RAW, &sock)) < 0) {
    printk("cantime.ko: Socket failure\n");
    return 1;
  }

  printk("cantime.ko: Socket 20\n");
  memset(&addr, 0, sizeof(addr));
  addr.can_family = PF_CAN;
  addr.can_ifindex = 2; // This is bad how do I dynamically find it?

  printk("cantime.ko: Socket 30");
  if (sock->ops->bind(sock, (struct sockaddr *)&addr, sizeof(struct
sockaddr) ) < 0) {
    printk("cantime.ko: Bind failure\n");
    return 1;
  }

  printk("cantime.ko: Socket 40\n");
  frame.can_id = 0x00050F93 | CAN_EFF_FLAG;
  frame.can_dlc = 6;
  frame.data[0] = 0x00;
  frame.data[1] = 0x02;

  memcpy(frame.data+2, &thetime, sizeof(int));

  printk("cantime.ko: Socket 50\n");
  if (sock_sendmsg(sock,(struct msghdr*)&frame,sizeof(struct
can_frame)) !=  sizeof(struct can_frame)) {
    printk("cantime.ko: Write failure");
    return 1;
  }

  sock_release(sock);
  set_fs(oldfs);

  return 0;

}

Output:
cantime.ko: Socket 10
cantime.ko: Socket 20
cantime.ko: Socket 30cantime.ko: Socket 40
cantime.ko: Socket 50
Unable to handle kernel paging request at virtual address 80050f93
pgd = d14c8000
[80050f93] *pgd=00000000
Internal error: Oops: 1 [#1] PREEMPT
Modules linked in: cantime(+) g_ether arcotg_udc
CPU: 0    Not tainted  (2.6.31-imx-09.12.00 #1)
PC is at raw_sendmsg+0x20/0x138
LR is at sock_sendmsg+0xa0/0xc4
pc : [<c02fe83c>]    lr : [<c0283c30>]    psr: a0000013
sp : d67fddc8  ip : c04246c4  fp : 00000000
r10: 0000bb38  r9 : d67fc000  r8 : 00000010
r7 : d67fded0  r6 : d679fe00  r5 : 00000000  r4 : 00000000
r3 : 00000010  r2 : 80050f93  r1 : d0d194e0  r0 : d67fdde8
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 914c8000  DAC: 00000017
Process insmod (pid: 13116, stack limit = 0xd67fc270)
Stack: (0xd67fddc8 to 0xd67fe000)
ddc0:                   d67fc000 000699b8 00000000 00000000 d67fded0 00000000
dde0: c0044fe4 c0283c30 c031b2a8 d785c4cc 00000000 00000001 ffffffff 00000000
de00: 00000000 00000000 00000000 00000000 d785c340 d67fde20 00000000 00000000
de20: 00002a89 d785c340 c00793d0 d67fde2c d67fde2c c031b278 00000000 00000016
de40: d67fde78 c0398293 d679ff38 d6aaa800 00000034 60000013 00000000 c0044fe4
de60: d6aaa800 0000bb38 00000000 c02feb94 00000000 d0d194e0 d6aaa800 d679fe00
de80: d6aaa800 00000010 d0d194e0 00000000 00000000 d67fded0 00000002 bf000000
dea0: 00000000 c0044fe4 d67fc000 0000bb38 00000000 c031ab78 00000000 d67fdee0
dec0: 00000002 bf000000 00000000 bf01837c 80050f93 bf019506 00000200 bf010000
dee0: 0000001d 00000002 00000000 00000000 00000000 d0d194e0 bf019528 00000000
df00: bf01877b bf0185e8 bf01877b c040e5d0 00000000 00000000 00000000 00000000
df20: 00000000 00000000 bf0188a0 00000000 00000000 00000000 00000000 00000000
df40: 00000000 00000000 00000000 0000003c 00000000 bf0193ac bf0184cc c004432c
df60: 00001e66 bf0193ac 00000000 000c9058 c0044fe4 00000000 bf0193ac 00000000
df80: 000c9058 c008d974 d6bcf6c0 d1477a60 be926ca4 00001e66 be926e67 00000002
dfa0: 00000080 c0044e60 00001e66 be926e67 000c9058 00001e66 000c9008 000c86b8
dfc0: 00001e66 be926e67 00000002 00000080 00000002 0000d33c 0000bb38 00000000
dfe0: be926ca0 be926c90 0001f87c 4001a8d0 20000010 000c9058 00000000 00000000
[<c02fe83c>] (raw_sendmsg+0x20/0x138) from [<c0283c30>] (sock_sendmsg+0xa0/0xc4)
[<c0283c30>] (sock_sendmsg+0xa0/0xc4) from [<bf01837c>]
(SendCanTime+0x10c/0x180 [cantime])
[<bf01837c>] (SendCanTime+0x10c/0x180 [cantime]) from [<bf0185e8>]
(cantime_init+0x11c/0x180 [cantime])
[<bf0185e8>] (cantime_init+0x11c/0x180 [cantime]) from [<c004432c>]
(do_one_initcall+0x5c/0x1c4)
[<c004432c>] (do_one_initcall+0x5c/0x1c4) from [<c008d974>]
(sys_init_module+0xc0/0x1d8)
[<c008d974>] (sys_init_module+0xc0/0x1d8) from [<c0044e60>]
(ret_fast_syscall+0x0/0x2c)
Code: e3520000 e1a08003 e591601c 0a000004 (e1d230b0)
---[ end trace 8599b84226905be0 ]---

I also have the user space code that works perfectly that I was trying to model
my kernel module code after:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <net/if.h>
#include <sys/ioctl.h>
#include <linux/socket.h>
#include <linux/can.h>
#include <linux/can/raw.h>

int main(int argc, char **argv)
{
  int s;
  struct sockaddr_can addr;
  struct ifreq ifr;
  struct can_frame frame;

  if ((s = socket(PF_CAN, SOCK_RAW, CAN_RAW)) < 0) {
    perror("Socket");
    return 1;
  }

  strcpy(ifr.ifr_name, "can0" );
  ioctl(s, SIOCGIFINDEX, &ifr);

  memset(&addr, 0, sizeof(addr));
  addr.can_family = AF_CAN;
  addr.can_ifindex = ifr.ifr_ifindex;
  printf("if index = %x\n", addr.can_ifindex);

  if (bind(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
    perror("Bind");
    return 1;
  }

  frame.can_id = 0x00050F93 | CAN_EFF_FLAG;
  frame.can_dlc = 6;
  frame.data[0] = 0x00;
  frame.data[1] = 0x02;

  int thetime = (int)time(NULL);
  memcpy(frame.data+2, &thetime, sizeof(int));

  if (write(s, &frame, sizeof(struct can_frame)) != sizeof(struct can_frame)) {
    perror("Write");
    return 1;
  }

  if (close(s) < 0) {
    perror("Close");
    return 1;
  }

  return 0;
}


                                                                               ^
