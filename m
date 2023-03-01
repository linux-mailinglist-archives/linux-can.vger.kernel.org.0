Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25276A73EE
	for <lists+linux-can@lfdr.de>; Wed,  1 Mar 2023 19:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCAS7N (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 1 Mar 2023 13:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCAS7M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 1 Mar 2023 13:59:12 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38A1F5EC
        for <linux-can@vger.kernel.org>; Wed,  1 Mar 2023 10:59:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677697149; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QgVbGRb1TO+TXvFz6EugiLIOeOa3buj7DLO+wlDjOy2DIriP7m0cctS76Vi5vybYNt
    ugHOrl1chAuVgEHV5Ah21uPxCx44FtP64mSqnITwXA55pGbVEUZq2v7L5t4BkukUy+B1
    tfjkcmypqGBlwePVoxxG/DMLL3R74g5+USij3r6cwUUemuZQwq8ZCo+FgtEXgySJulaX
    j1Y9q7PjcK8c04uIYEkeCliij3qRVZbqxtPR3Bu/hpSOs2wW764mrtBVS8p067n/Qxiv
    0eCfz5lY5/F1gO2KRLY/9QGSzv62A1tvFPFKP+vP1zCojplQ9Stu0pLik8Vc5hlCb9IA
    Gj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677697149;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=O7VkGRpIK6vJ1JUTBkjb3HCzKWTcq9RawZByyB6y/lw=;
    b=E1MRw68UurgiSWTrwtMh3DFmAIK2CN9E0VmvukIVpc5c3H9Tr17Fq39vxmWzbgoJp+
    lXRE80RCXlsPSzmlBn1MzDDRj73Z9EK17vfLDI1ovFKI2xPTrjpfa3TKooIctpV1I6/U
    JR5aodS4dkyX2yJc5/ee4ncz+pTEifQRxRDVx090MZ33CQ/RkLrDMT5xFS727YrIAZm8
    /VpSjBGOYux4O1KQdFvwmmQVghlGfGsTvwdX3xVEfic5pgK0uiFJIw3YEhyjohpBny4F
    AtmNZqzO8BQ5Ks4SwuOclMh0Urxd6Lq+ED+Yat1+eA4lV0f021/2VX0s28+FpEFYRyPh
    1S6Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677697149;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=O7VkGRpIK6vJ1JUTBkjb3HCzKWTcq9RawZByyB6y/lw=;
    b=pJRULPTmBNHH+ZDfRIX9XVFMzWsHNeMwElmRk9/kuxH4TnBW0e4ZJkopVprpo4ixQZ
    x33sjbEdpWymVfK74fi4rnEpdAEToavNDV7UjjzSqBZ+DIjBk89acrUb4B3RDSJNhEBC
    hyoFTGkZoPL/bXHf+iLCceEk3PbKLR6yN1nfcv+nX66OoGykB4ADv5RgWTIQIrkwYsuE
    hguzeDVm+IFH3/uaudfCfCJbEdlabn1XLFg94k33+vyBz52CFVa4BEoZKqq5r/3FwiUb
    u6gsySWj80Sa2/IOOrMSeHSB1fNlhkT7UXAkKZnvlJqoqOoC90FhKk5w3RIs1GWFML6i
    KstQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z21Ix84Vl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 1 Mar 2023 19:59:08 +0100 (CET)
Message-ID: <08d8e225-0e7a-a75f-f8fa-e4a8ce99d4a4@hartkopp.net>
Date:   Wed, 1 Mar 2023 19:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: please re-send [RFC PATCH] can: isotp: fix poll() to not report
 false positive EPOLLOUT events
Content-Language: en-US
To:     Michal Sojka <michal.sojka@cvut.cz>,
        Jakub Jira <jirajak2@fel.cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
 <878rghtt0p.fsf@steelpick.2x.cz>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <878rghtt0p.fsf@steelpick.2x.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michal,

just copied the text to answer your patch ...

On 28.02.23 21:49, Michal Sojka wrote:

 > When using select/poll/epoll() with a non-blocking ISOTP socket to
 > wait for when non-blocking write is possible, false EPOLLOUT event is
 > sometimes returned. This can happen at least after sending a message
 > which must be split to multiple CAN frames.
 >
 > The reason is that isotp_sendmsg() returns -EAGAIN when tx.state is
 > not equal to ISOTP_IDLE and this behavior is not reflected in
 > datagram_poll(), which is used in isotp_ops.
 >
 > This is fixed by introducing ISOTP-specific poll function, which
 > suppresses the EPOLLOUT events in that case.


Good improvement!

 > Below is a program that can trigger the problem on a vcan interface.
 > When running the program as:
 >
 >      ./isotp-poll-test -s 123 -d 321 -o
 >
 > it starts sending ISOTP messages that include increasing ASCII
 > numbers. poll() is used to wait before next transmission.
 >
 > With current mainline Linux, once the message length is greater than 7
 > bytes, write() returns -EAGAIN and the program terminates. This should
 > not happen, because the previous poll() reported that the write()
 > would not block.
 >
 > After applying this patch, the above command doesn't fail - if one
 > runs some ISOTP reader such as:
 >
 >      isotprecv -l -s 321 -d 123 vcan0
 >

Yes, I can confirm that the above setup works - but not reliable:

 > This test program can also show another problem. When running:
 >
 >      ./isotp-poll-test -s 321 -d 123 -i -a
 >
 > and then in another terminal:
 >
 >      ./isotp-poll-test -s 123 -d 321 -o
 >
 > The first program receives the messages and uses the counter values to
 > check for lost messages. After a random number of iterations a lost
 > message is always detected. I believe that ISOTP should be reliable
 > protocol, at least on vcan, shouldn't it?

The problem seems to occur with the new introduced POLL feature.

When using

	./isotp-poll-test -s 123 -d 321 -o

together with

	isotprecv -l -s 321 -d 123 vcan0

the transmission of isotp PDUs stops at some point
#8179 #6204 #1787 #373 #69321 etc

I can not see problems or drops when using

./isotpsend vcan0 -s 123 -d 321 -D 9 -li

as data producer where I added a counter:

diff --git a/isotpsend.c b/isotpsend.c
index deac601..815c254 100644
--- a/isotpsend.c
+++ b/isotpsend.c
@@ -96,10 +96,11 @@ int main(int argc, char **argv)
      useconds_t usecs = 0; /* wait before sending the PDU */
      __u32 force_tx_stmin = 0;
      unsigned char buf[BUFSIZE];
      int buflen = 0;
      int datalen = 0;
+    u_int32_t datainc = 0;
      int retval = 0;

      addr.can_addr.tp.tx_id = addr.can_addr.tp.rx_id = NO_CAN_ID;

      while ((opt = getopt(argc, argv, "s:d:x:p:P:t:f:D:l:g:bSCL:?")) != 
-1) {
@@ -295,10 +296,13 @@ int main(int argc, char **argv)

  loop:
      if (usecs)
             usleep(usecs);

+    memcpy(&buf[datalen - 4], &datainc, 4);
+    datainc++;
+
      retval = write(s, buf, buflen);
      if (retval < 0) {
             perror("write");
             return retval;
      }


Maybe the 'poll' patch needs to check for something else. I will take a 
look at it.

Many thanks,
Oliver

