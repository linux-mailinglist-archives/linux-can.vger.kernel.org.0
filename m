Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C717714DA98
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2020 13:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgA3M2S (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Jan 2020 07:28:18 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:34205 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgA3M2S (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2020 07:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580387296;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=xOK5u0VSaeCu0tF9gJtwHCUBKf4xkGHQOQmIINxKhlk=;
        b=jPTM0zWfWQ77eEf9fUa/p29zsSha75fLS10CC31XUsQXI+O8CFVz75HDz/QnIRC9LF
        02fIT97m2H1Nr0iyOYEOh2SOf1PsId1oAZ/1CNRjY8lIVfl0l3jwCnlD7vgC0y+en/qb
        5qREEcqdWibhnlCS3wia9o8dLz36lbBvkaSN+mUQxFVl5MT+LBDTfj3sACGVUZtCh4iF
        o3Zft/iFCm/hyT1hsGQ9iH4T0oBoH5kUtGtdDuaLP8kK0FPAjsya4tZn6xoetSEpqEcg
        Lkd/ZpznLAZ8TorlWTi9/QzEfSThSolaGzEbrCAsS0YbdO4mFG+nf849K2k7WYEcm/k9
        Nyew==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS8nvQfEUpxpWaP+a2CUQ=="
X-RZG-CLASS-ID: mo00
Received: from silver.be.tmme.com
        by smtp.strato.de (RZmta 46.1.10 AUTH)
        with ESMTPSA id Y06e5dw0UCPA0FM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jan 2020 13:25:10 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     linux-can@vger.kernel.org
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH RFC] can-utils: candump: remove bridging functionality
Date:   Thu, 30 Jan 2020 13:24:57 +0100
Message-Id: <20200130122457.1875-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The tool 'candump' is used to dump CAN traffic to stdout or logfile.
In early days where the in-kernel CAN gateway (can-gw) with the cangw tool was
not yet implemented the bridging functionality allowed to send received (and
filtered) CAN frames to another outgoing CAN interface.

As we now have can-gw and sending CAN frames from a 'reading tool' seems wrong
especially from the Unix philosophy "Write programs that do one thing and do
it well." this patch removes the obsolete functionality from candump.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 candump.c | 70 +------------------------------------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/candump.c b/candump.c
index f2ff03b..16382d1 100644
--- a/candump.c
+++ b/candump.c
@@ -125,9 +125,6 @@ void print_usage(char *prg)
 	fprintf(stderr, "         -a          (enable additional ASCII output)\n");
 	fprintf(stderr, "         -S          (swap byte order in printed CAN data[] - marked with '%c' )\n", SWAP_DELIMITER);
 	fprintf(stderr, "         -s <level>  (silent mode - %d: off (default) %d: animation %d: silent)\n", SILENT_OFF, SILENT_ANI, SILENT_ON);
-	fprintf(stderr, "         -b <can>    (bridge mode - send received frames to <can>)\n");
-	fprintf(stderr, "         -B <can>    (bridge mode - like '-b' with disabled loopback)\n");
-	fprintf(stderr, "         -u <usecs>  (delay bridge forwarding by <usecs> microseconds)\n");
 	fprintf(stderr, "         -l          (log CAN-frames into file. Sets '-s %d' by default)\n", SILENT_ON);
 	fprintf(stderr, "         -L          (use log file format on stdout)\n");
 	fprintf(stderr, "         -n <count>  (terminate after reception of <count> CAN frames)\n");
@@ -217,8 +214,6 @@ int main(int argc, char **argv)
 {
 	fd_set rdfs;
 	int s[MAXSOCK];
-	int bridge = 0;
-	useconds_t bridge_delay = 0;
 	unsigned char timestamp = 0;
 	unsigned char hwtimestamp = 0;
 	unsigned char down_causes_exit = 1;
@@ -257,7 +252,7 @@ int main(int argc, char **argv)
 	last_tv.tv_sec  = 0;
 	last_tv.tv_usec = 0;
 
-	while ((opt = getopt(argc, argv, "t:HciaSs:b:B:u:lDdxLn:r:heT:?")) != -1) {
+	while ((opt = getopt(argc, argv, "t:HciaSs:lDdxLn:r:heT:?")) != -1) {
 		switch (opt) {
 		case 't':
 			timestamp = optarg[0];
@@ -301,52 +296,6 @@ int main(int argc, char **argv)
 			}
 			break;
 
-		case 'b':
-		case 'B':
-			if (strlen(optarg) >= IFNAMSIZ) {
-				fprintf(stderr, "Name of CAN device '%s' is too long!\n\n", optarg);
-				return 1;
-			} else {
-				bridge = socket(PF_CAN, SOCK_RAW, CAN_RAW);
-				if (bridge < 0) {
-					perror("bridge socket");
-					return 1;
-				}
-				addr.can_family = AF_CAN;
-				strcpy(ifr.ifr_name, optarg);
-				if (ioctl(bridge, SIOCGIFINDEX, &ifr) < 0)
-					perror("SIOCGIFINDEX");
-				addr.can_ifindex = ifr.ifr_ifindex;
-		
-				if (!addr.can_ifindex) {
-					perror("invalid bridge interface");
-					return 1;
-				}
-
-				/* disable default receive filter on this write-only RAW socket */
-				setsockopt(bridge, SOL_CAN_RAW, CAN_RAW_FILTER, NULL, 0);
-
-				/* try to switch the bridge socket into CAN FD mode */
-				setsockopt(bridge, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &canfd_on, sizeof(canfd_on));
-
-				if (opt == 'B') {
-					const int loopback = 0;
-
-					setsockopt(bridge, SOL_CAN_RAW, CAN_RAW_LOOPBACK,
-						   &loopback, sizeof(loopback));
-				}
-
-				if (bind(bridge, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
-					perror("bridge bind");
-					return 1;
-				}
-			}
-			break;
-	    
-		case 'u':
-			bridge_delay = (useconds_t)strtoul(optarg, (char **)NULL, 10);
-			break;
-
 		case 'l':
 			log = 1;
 			break;
@@ -706,20 +655,6 @@ int main(int argc, char **argv)
 
 				if (count && (--count == 0))
 					running = 0;
-
-				if (bridge) {
-					if (bridge_delay)
-						usleep(bridge_delay);
-
-					nbytes = write(bridge, &frame, nbytes);
-					if (nbytes < 0) {
-						perror("bridge write");
-						return 1;
-					} else if ((size_t)nbytes != CAN_MTU && (size_t)nbytes != CANFD_MTU) {
-						fprintf(stderr,"bridge write: incomplete CAN frame\n");
-						return 1;
-					}
-				}
 		    
 				for (cmsg = CMSG_FIRSTHDR(&msg);
 				     cmsg && (cmsg->cmsg_level == SOL_SOCKET);
@@ -862,9 +797,6 @@ int main(int argc, char **argv)
 	for (i=0; i<currmax; i++)
 		close(s[i]);
 
-	if (bridge)
-		close(bridge);
-
 	if (log)
 		fclose(logfile);
 
-- 
2.20.1

