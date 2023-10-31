Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF987DC985
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbjJaJaX (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbjJaJaU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:20 -0400
X-Greylist: delayed 79130 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 02:30:18 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B95D8;
        Tue, 31 Oct 2023 02:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744594; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Fwa8oJylUw3RGkcgug1yHwLZvusWKDGyw063fbbqX4kuFZZCxOLGA02tNslp4O79rC
    c4EWihyMPshETtfZsu2E74O3XJdD28uy8+rKZPqFy5B4pr2wvXOAC5t9i3Vr8i4IR2I8
    ftOEZDuho3R0vw9UY4BuW17isK6EHyTLfzmnq0ywoA51ni2yynd9Sw0lJIuwZhSAu3bB
    sKPbiKr7+7cvKJvPmL9vEP/OqPcaQyqi0fdUmUGXCpUhu7wCjSe68hB3J+8qsUec8SyD
    0FQun9HSXYeLYEVxu5wXtkjN/5rq2Y8RJOHk+Q/e3BERqlLh3KstTbbDG6ZgTzX0DPAS
    JGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744594;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZfFTC5Dx7oItzKGDdq61zrmPGDnUDc64z2Z7f0RNLbI=;
    b=Aoos+i4HjKysrP7uwLnkQRyv0PFBkuSLMz1fsczH08OaVpt4pmaqYtIlsQiujbUJY9
    1q0Ud0Z3VJ+2ppFtqaT5eZSTdz/56ol7f4Ld+Ey/bOMdvpOpv/y+H07mfwc0jYjsy9Qq
    /biyzEq+Fp1EX53ihv/tykcI1v4S4LUJ42s11cygJ/7F1bnIeiP5gKf6R6RbCKgypigM
    wDVQJ851ZdxGGWDJ0DiA3QEbLthvS9RgaoYpnQgbaLrBC/q6RbzKCZrw30fbxC1DcOA8
    PJsCIks/+FGpTlp7hE+ez9/5R8pY43ckMvYuXAN1x9ppwCxIEVMJU+90wqmzPFKEzAk6
    1kcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744594;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZfFTC5Dx7oItzKGDdq61zrmPGDnUDc64z2Z7f0RNLbI=;
    b=g5xaFsFabLVpLaPVNQnMGCVn7mHokPOniSQ7GTkWnxF4cyUus3JzpP6A6QAqU3v16q
    6s9E1t01IguV0vYZhMxfltQdk2jo4p3L6DatTJ6o8f4hmlC6mG0PDW5mEHnXUMAjZ8dA
    EndebLmPWB2iAfhcTGHW9u7I5ugbJe5KUfEr1U9YIGo5QCzZvvDayJExnb87vXeLRk3u
    +D6+9IUN7BPQI47uJVSjz0JVeTYbgJJeVFqw4KHV8SxcpI9PIJ6DA0at6CvWJGp3HZPu
    EVDWKNAZCrFFm81AAolOMPVKooV+FP9U2wF3gCzSLYmM7ARMFscnCX/Ah0hbin/TNfHb
    sOOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744594;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZfFTC5Dx7oItzKGDdq61zrmPGDnUDc64z2Z7f0RNLbI=;
    b=ItHlohsoKaWinidjvzhRN4BkA0J3WTuA+WmSbXnG46g6alZ1sJrQ2KzDIzHJQrgF2t
    vvAJcrvCUVbGzKIu2fBQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9TrFhB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:29:53 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.10 00/10] can: isotp: upgrade to latest 6.1 LTS code base
Date:   Tue, 31 Oct 2023 10:29:08 +0100
Message-Id: <20231031092918.2668-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
not report false EPOLLOUT events") introduced a new regression where the
fix could potentially introduce new side effects.

To reduce the risk of other unmet dependencies and missing fixes and checks
the latest 6.1 LTS code base is ported back to the 5.10 LTS tree.

Lukas Magel (1):
  can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Oliver Hartkopp (6):
  can: isotp: set max PDU size to 64 kByte
  can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
  can: isotp: check CAN address family in isotp_bind()
  can: isotp: handle wait_event_interruptible() return values
  can: isotp: add local echo tx processing and tx without FC
  can: isotp: isotp_bind(): do not validate unused address information

Patrick Menschel (3):
  can: isotp: change error format from decimal to symbolic error names
  can: isotp: add symbolic error message to isotp_module_init()
  can: isotp: Add error message if txqueuelen is too small

 include/uapi/linux/can/isotp.h |  25 +-
 net/can/isotp.c                | 434 +++++++++++++++++++++------------
 2 files changed, 293 insertions(+), 166 deletions(-)

-- 
2.34.1

