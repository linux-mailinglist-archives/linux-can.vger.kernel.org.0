Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC0379209
	for <lists+linux-can@lfdr.de>; Mon, 10 May 2021 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhEJPG5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 10 May 2021 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236362AbhEJPFm (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 10 May 2021 11:05:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C6EC04371A
        for <linux-can@vger.kernel.org>; Mon, 10 May 2021 07:23:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m9so16855754wrx.3
        for <linux-can@vger.kernel.org>; Mon, 10 May 2021 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=PDrKXaT82d+xAHSbLCjF5KCIqlkVFiR8ZBJAjsZsFZg=;
        b=ihXAWv8OUnuKstR+NRiDMvuv9QZldPeJPPmL+nCUBhjMvZ0qA3U+KxiLxKJgKFAJAF
         9asFNFYj0JqkTK5fbzdUUZofmo7bTsdrY8YAUp1nhPpJgS0/R3I4J6LdfaL2Sdb3ZzgA
         R4M+H8RX/1BIkq6M57eTnHveGAQ+UXHcnuGy+nI/BFS5aa+4Yik8hwHhSQ6AflzC6rOp
         0zJZM3Yse2gIPQCUZ7f6DptI3LrSk0+f3aEeVMP+SSjHV+0SgieYk/Ml7orYnuGHVG/g
         grwwITTmdXhgRWEYgPkEmHF91q8chZtfJtna4tH3S4LNwXXQ3p4euitVUb4cznvYBWX+
         HCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=PDrKXaT82d+xAHSbLCjF5KCIqlkVFiR8ZBJAjsZsFZg=;
        b=seco14Tf5ycAji542DPWRpHgfU5DirQthbRZUURZyCcRs59LE0aIZJ9jjWd7g8D6JI
         RT8pqMa8Cey/ODPnR6StwOduwewPrhK2xmqFN6L0A81eD9FxRQbGPcV6ByPQ4NjB6MMW
         u+gHBr6dCMyqhjY7T0Dp4JVU8AnkC2qje6x3wE7vkH30EExq8aXrtJKfwRmj40VSPnae
         t+pvS3rm54+Iyb7cy1i1uJFTvxIQ11WI4+47WeRUh2NQzEuYXDQoOOvqMTb8eMWgSJef
         Y4GHOfQkCqzL88RPxJ19Z/rtsk0GYagO/hcAXtTWLEY9vSrOlVcmYgf9IZ5/OGlhGDug
         zKog==
X-Gm-Message-State: AOAM531aJChn5bdVvbOIl7tar5LuNiJUHfQQyrx9rhSesGQy4F+b8JNJ
        Rxz8oLlLsktPaTPNiC8NAa8vsSF98fPPycNn
X-Google-Smtp-Source: ABdhPJzgDK7SM7or7yCg5eAv08+yfo49wteKQz1vFKmEQj5A0uOQYiXjwQLyt2xQ18hpDxlk+TGVLQ==
X-Received: by 2002:a5d:5610:: with SMTP id l16mr32080794wrv.106.1620656585528;
        Mon, 10 May 2021 07:23:05 -0700 (PDT)
Received: from bigthink (92.41.10.184.threembb.co.uk. [92.41.10.184])
        by smtp.gmail.com with ESMTPSA id u5sm23002599wrt.38.2021.05.10.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:23:05 -0700 (PDT)
Date:   Mon, 10 May 2021 15:23:02 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: CAN: TX frames marked as RX after the sending socket is closed
Message-ID: <20210510142302.ijbwowv4usoiqkxq@bigthink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

Scenario: I open a raw CAN socket, queue a bunch of frames for TX, then
close the socket as soon as possible. For the duration of the test, I
have another socket open listening for all frames (candump).

After the sending socket has been closed, and there are still frames in
the queue yet to be transmitted, I find candump reporting the remainder
of my sent frames as RX rather than TX.

For example, I send 1,000 8-byte classical CAN frames, immediately close
the socket and log the time at which I did so.

My application reports the socket closed:

| Socket closed at 15:02:45.987278

My candump log shows:

| (2021-05-10 15:02:45.327724)  can0  TX - -  000  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.329578)  can0  TX - -  001  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.330493)  can0  TX - -  002  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.331341)  can0  TX - -  003  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.332264)  can0  TX - -  004  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.333148)  can0  TX - -  005  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.334115)  can0  TX - -  006  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.335061)  can0  TX - -  007  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.336021)  can0  TX - -  008  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:45.336951)  can0  TX - -  009  [08]  EE EE EE EE EE EE EE EE
| 
| .... snip ....
|
| (2021-05-10 15:02:46.089177)  can0  TX - -  399  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.090001)  can0  TX - -  39A  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.090852)  can0  TX - -  39B  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.091735)  can0  TX - -  39C  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.092483)  can0  TX - -  39D  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.093313)  can0  RX - -  39E  [08]  EE EE EE EE EE EE EE EE <----- !!!!!
| (2021-05-10 15:02:46.094091)  can0  RX - -  39F  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.094931)  can0  RX - -  3A0  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.095774)  can0  RX - -  3A1  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.096513)  can0  RX - -  3A2  [08]  EE EE EE EE EE EE EE EE
|
| .... snip ....
|
| (2021-05-10 15:02:46.143287)  can0  RX - -  3DE  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.144046)  can0  RX - -  3DF  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.144808)  can0  RX - -  3E0  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.145570)  can0  RX - -  3E1  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.146357)  can0  RX - -  3E2  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.147117)  can0  RX - -  3E3  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.147876)  can0  RX - -  3E4  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.148635)  can0  RX - -  3E5  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.149395)  can0  RX - -  3E6  [08]  EE EE EE EE EE EE EE EE
| (2021-05-10 15:02:46.150161)  can0  RX - -  3E7  [08]  EE EE EE EE EE EE EE EE

Why?

candump.c prints 'RX' if the received frame has no MSG_DONTROUTE flag.

|	if (msg.msg_flags & MSG_DONTROUTE)
|		printf ("  TX %s", extra_m_info[frame.flags & 3]);
|	else
|		printf ("  RX %s", extra_m_info[frame.flags & 3]);

In turn, MSG_DONTROUTE is set in net/can/raw.c: raw_rcv():

|	/* add CAN specific message flags for raw_recvmsg() */
|	pflags = raw_flags(skb);
|	*pflags = 0;
|	if (oskb->sk)
|		*pflags |= MSG_DONTROUTE;
|	if (oskb->sk == sk)
|		*pflags |= MSG_CONFIRM;

So, I'm guessing, some 100 ms after my application begins to request
that the socket be closed, the socket's pointer becomes NULL in further
TX skbs in the queue, so the raw CAN layer can no longer differentiate
these skbs as TX. (Sorry if my pathways are a bit mixed up.)

Seems broken to me - is this known behaviour?

Test setup:
 - kernel: v5.13-rc1 with some RPi-specific patches
 - hardware: RPi CM4 with TCAN4550 (so, m_can driver in peripheral mode)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

