Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A827DC99A
	for <lists+linux-can@lfdr.de>; Tue, 31 Oct 2023 10:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbjJaJav (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 31 Oct 2023 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjJaJau (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 31 Oct 2023 05:30:50 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D4C2;
        Tue, 31 Oct 2023 02:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698744631; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=J1hGgICqpAXwMnbk00gjE8sOvoG7oa2rTLRJp6PF1cfUPu2g3MYs19uzj3CLGAfOmE
    upWNeMkR7WEIrjmZJutkAYovaJos2CZvcNaOH5g2IAxPaMB1OFLKhPrEcp9MHEzV0O25
    d4z5FXSR9Qxi1Y7KqcygYSQIg5B6UlY1ucVn8MclrAhLSxiIs8XKeowThXw4H5L2fyyl
    udyXxaoI4OIU1yePZpY5uwUhZlTnA7V/bdV52oC35CiowvDUdBzBo7NgblKmdE2GvqQY
    o8WsrJMXPaBq2oTalhyzgEGxkN9TCi8z2+x+9Si5s0FjNsrG/VfLSFvOifDJDok7DJiU
    vglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744631;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EIFKe/kiDjqM3gc1TwhgXhITCSOkVOKMmOGdgm3AizA=;
    b=hg8Hk3LRm5GukTzabMrljridcoKd3psZTrhrux187PW/8Hkxv4c29JDyg8UDG6ffSU
    n7l/lmp08ULWya2QSwyD/2j5wKedmtFa9hCO2YqgbaOBl3R2JWcLB6rmQWCNBPAC+8tM
    ich3Yp5Q3InKHk57Ve48/dF3YKdp+VD88YEpVzvRKIxTcF9Bwz6YUziyriy9y/C6flgH
    wjOPp9MLtpSy1I54WbtL1i71n4X1P8byxsJI4Z+pL7THtZnBWTzZi4NWwcBLsbSoJ9GZ
    kH17kUDVMpL/L0V3owB8TwL9yxZPkHDMsZ+OSbrnlp5lkJWjlaSt1QzPJWG/pw9Lx08i
    UsSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698744631;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EIFKe/kiDjqM3gc1TwhgXhITCSOkVOKMmOGdgm3AizA=;
    b=Nvb7JAYaHLXP4AeIRHm5+hQKHjUYHL74M+BggH1HaC9EnX0UqrjmVAh+uTb9EGvZoq
    0JRmf/DFbGOVedHEw1VefCjQQ7QQnMxdoxSc5cfBzTQeVMSnaSA0yzuQtNoXdBtv9IZ8
    WTkTOUguK7tAI3AUIcXEwbwTYHk0B3Cwr8KmSygrih8p4kUC1mV5+fKlN63uPXSFQt37
    ZGEhYuC2fjSswqxO8pq4id5hEFU37RIgUh9+8nk2cgeGWMRMMwl/pJKN32Fsy6sQEU84
    3PZ73NAV8GBRYH2+nZ3ZzgXOiFNukF2GRurYjZfAmW7c/Ss5Ky7Qdl6Xm89A7k7LG9oU
    GEsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698744631;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=EIFKe/kiDjqM3gc1TwhgXhITCSOkVOKMmOGdgm3AizA=;
    b=flMJiKZtGSfoZ7t9OWDqZ/AvdRpN/IEw4zATpYYFEA/ap3YYiZgoJ0wbSBjFQ7fpse
    VbtTV20uufaZPE5WQXDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS0k+8CejuVITM8sik0"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9V9UVFhX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 31 Oct 2023 10:30:31 +0100 (CET)
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Cc:     linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH stable 5.15 0/7] can: isotp: upgrade to latest 6.1 LTS code base
Date:   Tue, 31 Oct 2023 10:30:18 +0100
Message-Id: <20231031093025.2699-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
not report false EPOLLOUT events") introduced a new regression where the
fix could potentially introduce new side effects.

To reduce the risk of other unmet dependencies and missing fixes and checks
the latest 6.1 LTS code base is ported back to the 5.15 LTS tree.

Lukas Magel (1):
  can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Oliver Hartkopp (6):
  can: isotp: set max PDU size to 64 kByte
  can: isotp: isotp_bind(): return -EINVAL on incorrect CAN ID formatting
  can: isotp: check CAN address family in isotp_bind()
  can: isotp: handle wait_event_interruptible() return values
  can: isotp: add local echo tx processing and tx without FC
  can: isotp: isotp_bind(): do not validate unused address information

 include/uapi/linux/can/isotp.h |  25 +-
 net/can/isotp.c                | 426 +++++++++++++++++++++------------
 2 files changed, 288 insertions(+), 163 deletions(-)

-- 
2.34.1

