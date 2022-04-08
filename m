Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928844F9EEF
	for <lists+linux-can@lfdr.de>; Fri,  8 Apr 2022 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiDHVMm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Apr 2022 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239815AbiDHVMf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2022 17:12:35 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 601F3181160
        for <linux-can@vger.kernel.org>; Fri,  8 Apr 2022 14:10:27 -0700 (PDT)
Received: from localhost.localdomain ([93.35.164.10])
        by Aruba Outgoing Smtp  with ESMTPSA
        id cvr9nij0B79nYcvr9nFy4n; Fri, 08 Apr 2022 23:09:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1649452164; bh=TjYG3E/+cnICxb5g+LSNmbTgbBfI9nG8Ag6knqdfm8U=;
        h=From:To:Subject:Date:MIME-Version;
        b=I5NhBaSSfmYcQu5wOwDE89N2XVVdtJRATQJa7gu3WuuZloBeeovmy2UVDzgUZUG6s
         nh3R+97z7MQFwQN+5SxYODrfSVOPZrVFGJStWWqimsMC05IAAgMkG1ylsJkpa3fnwi
         ng9lt4ejgoNY40Nj769BjBWVaVhkqT+tSKSMJKKeSRTdQAMzkq7Y50hZeyDtkHpYjl
         qSyr9a96ot/27DnlTDXKotfMWyUAtgad7X37s1rn/g/yxqIPscMnGkZa6w7tf7d22P
         XfjDngPHSDw/Stq1yI3UHWcwCdomswqi8Xxrc4yVpBldQO6sQENGWr9wFJ47KRZKCS
         8E3JlTRFBN7qA==
From:   Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
To:     Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        Devid Antonio Filoni <devid.filoni@egluetechnologies.com>
Subject: [PATCH 0/2] j1939: make sure that sent DAT/CTL frames are marked as TX
Date:   Fri,  8 Apr 2022 23:09:08 +0200
Message-Id: <20220408210910.16137-1-devid.filoni@egluetechnologies.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDs1cPSwuRdiCSLtLZyqg37B4TVJbz+ZxjWCtbMZPzJozG1yKobeZbVpzXO0x9SmaEyQtcDImFttjQcqnnnv1TM3NjUCsPZE7tkOZi/JsM1kNMO6IfCb
 IFFxc4/vAv66/aVNKIOmayo1RBwRlGJOm1JViFkm7PxJH55q5fT5V6Ujg2wvrXOsRGzjXmDUm4Xrt+IOEvkqCny711VJk4svtjAC08PGbq0o4urnbh2i0o7Z
 pgmC719EQuQsFhZMjb/PLNR7t+kqtueK7+5ghMe5nICdd292A41SY2BprEDK7jVSDb79YwTHkGceCVccT7yGBR2SocN4zQ+K52CLS72/IXvXq8sSFFxI7rTJ
 8qAlmjUPegJgTcWd2Ky6Sdmpooc/pA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

If candump -x is used to dump CAN bus traffic on an interface while a J1939
socket is sending multi-packet messages, then the DAT and CTL frames
show up as RX instead of TX.

This patch series sets to generated struct sk_buff the owning struct sock
pointer so that the MSG_DONTROUTE flag can be set by recv functions.

I'm not sure that j1939_session_skb_get is needed, I think that session->sk
could be directly passed as can_skb_set_owner parameter. This patch
is based on j1939_simple_txnext function which uses j1939_session_skb_get.
I can provide an additional patch to remove the calls to
j1939_session_skb_get function if you think they are not needed.

Thank you,
Devid

Devid Antonio Filoni (2):
  can: j1939: make sure that sent DAT frames are marked as TX
  can: j1939: make sure that sent CTL frames are marked as TX

 net/can/j1939/transport.c | 69 ++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 12 deletions(-)

-- 
2.25.1

