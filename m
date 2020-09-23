Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5C275AD6
	for <lists+linux-can@lfdr.de>; Wed, 23 Sep 2020 16:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWOz0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 23 Sep 2020 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgIWOz0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 23 Sep 2020 10:55:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B80C0613CE
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 07:55:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id g128so23980741iof.11
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2020 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2+cqs/Gpsd7yx6dQQGeoUSkIUlOdN23gEn//UIChkpw=;
        b=DvAP4s0TzVtDtwtAmauRjvajmiDrNrnXKy4TC1LJpcZeLGUm+7ENqzMFmNhFT2Rf90
         rE2cwwb0ongxBEXYgIIx/7LeeV1CJf/u5mKE9c/6mBf2zywkLWTAiippP2UtxyJa8/Sc
         lRMJtcxhl+BY/34fLyPBEzwiBN+vrpIHDjFSbTTSD49HhwnJg6Gaypg3mywbCzNfxGKq
         JcmQTofRtmfKv6MHPDRshbNyTr4eS6gHWX/Vfu1xD7ii+2CjXBs4KpbQQJpIlbYqNluJ
         GnXRDDalID82fr0yDoATXgk3WeMEcs4nXGSAtmTZaTHuWO26Dm/V+CCp/yhlEHAEzkRV
         IcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2+cqs/Gpsd7yx6dQQGeoUSkIUlOdN23gEn//UIChkpw=;
        b=ukicnZtv40/MF7OFzkYWhUDb6JaAawnVswgHjfAr7NeofEGyRVANMOGPR2uE3y8VZ1
         WRU576KbhaiiPQBAmxghAgGQeJBisAEoJX7pFTdWOBA1yw6UGJbUf9qDBIKEXIRtvS5o
         1aRdRScfKttXGPEuTCSnxRAU65S1+7I1FtcBMbdQYvxjQZfd59HFn4gmb9TzPV2ff5Me
         wTSn/XzdaY4xI55g4/tlaBmG04tdya9zgvSnN5ZfCMwVzx4N/WD2YpWnLumb7yGg39Z1
         f1zTaEonwTommLvISrEpG+/E4PhBGbfc+XXaSCznJFMElIcZkSmB8a9y/7jH2uCPz+Wj
         GVzw==
X-Gm-Message-State: AOAM532UNgm77MBxQNHPdB4JgDSbrVsNusHG1mUDLLRTxGyJW+6ULYqL
        QND8zdgIC9wx4KOMfc0cJ0NHIu5Uv0V5p8n6nQd0/uN9Gg==
X-Google-Smtp-Source: ABdhPJxTGXaz0hJLBWbWneP3oTHlqgi9SJm/n9ThrsTdX5+Ryl3zyqF1GdKEpL4shTHMQHtDLnwjjz7ZIDCmQ9alV2Y=
X-Received: by 2002:a02:665d:: with SMTP id l29mr8549971jaf.97.1600872925117;
 Wed, 23 Sep 2020 07:55:25 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Matthias_Wei=C3=9Fer?= <m.weisser.m@gmail.com>
Date:   Wed, 23 Sep 2020 16:55:13 +0200
Message-ID: <CAO8h3eGqrxFMKrsrjECeog6cheLrRpn_y6Ty9BMUv_ncU1c67g@mail.gmail.com>
Subject: mcp25xxfd driver testing
To:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi

I currently try to get a MCP2518FD to work on our custom iMX6ULL based
hardware. I use the driver currently in linux-can-next backported to
our v5.4 kernel

DT:
    can0: can@0 {
        compatible = "microchip,mcp25xxfd";
        reg = <0>;
        clocks = <&can3_osc>;
        spi-max-frequency = <85000000>;
        interrupts-extended = <&gpio1 18 IRQ_TYPE_LEVEL_LOW>;
        status = "okay";
    };

 # dmesg | grep mcp
[    3.706085] mcp25xxfd spi1.0 can0: MCP2518FD rev0.0 (-RX_INT
-MAB_NO_WARN +CRC_REG +CRC_RX +CRC_TX +ECC -HD c:20.00MHz m:8.50MHz
r:8.50MHz e:0.00MHz) successfully initialized.

I then up the CAN interface
# ip link set can0 up type can bitrate 125000 sample-point 0.75
dbitrate 500000 dsample-point 0.8 fd on

I am then able to send CAN frames using
# cansend can0 123#42
and CAN-FD frames using
# cansend can0 123##042

These frames are successfully received on a connected PC using an PCAN-USB FD

Trying to send a CAN-FD frame with baud rate switch fails
# cansend can0 123##142
[  190.921477] mcp25xxfd spi1.0 can0: bus-off

Also receiving of any CAN frame doesn't work
# candump any,0:0,#FFFFFFFF
[  259.937612] spi_master spi1: I/O Error in DMA RX
[  259.943743] mcp25xxfd spi1.0: SPI transfer failed: -110
[  259.949644] spi_master spi1: failed to transfer one message from queue
[  259.956566] mcp25xxfd spi1.0 can0: IRQ handler
mcp25xxfd_handle_rxif() returned -110.
[  259.964547] mcp25xxfd spi1.0 can0: IRQ handler returned -110
(intf=0x3f1a0002).

My first thought was that the interrupts of the controller are not
recognized by the iMX but /proc/interrupts shows that there are some
of them
 78:         10  gpio-mxc  18 Level     spi1.0

Any hints are greatly appreciated


Regards

Matthias
