Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6F580038
	for <lists+linux-can@lfdr.de>; Mon, 25 Jul 2022 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiGYNyK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Mon, 25 Jul 2022 09:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiGYNyI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 25 Jul 2022 09:54:08 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA615802
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:54:06 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id d124so2708437ybb.5
        for <linux-can@vger.kernel.org>; Mon, 25 Jul 2022 06:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ac81WFcClhe6PKs5MHDPcIypOaRXDUg/uSJ7/mPX0as=;
        b=ylC5Jt4QbQXQOJms5/M2leVxd9qvZJPalgzLt6hk+G532mNCkUslyDrDLvTvdeX2bO
         ud1TOL00XF+PkH2PC/F6Bxsriqzd+popDez8wbwalqgIfzaF8Xl/AtJIAKJUcMCo9NaR
         QUoqGqfUznTkR2G1Y1N7ErTQs8dnda5fw3uy7F9jzT8HJrl5juJIoccetjEPcZvTRRWX
         aYjOHQRZ2dq5Fd90JP6EYWO+bRrO2AnXxkvfrGfo9CZqFgZtYPmcj4M7cy7y2toIIiT2
         M3c77pvMeCk+++gQ15eV5Yr5dchH27IAaWMovDrcxkj3wq183sE9oB6fDOPnDpRGTplO
         jBIw==
X-Gm-Message-State: AJIora8aHJKEiU8I1r7cTh/JhCLSYEmsBs9a9IJ6VDzW5MBD3E8pzbZw
        JHV8T2L44HHxtEfQ5WqHgVJtnlnmrxVp1AdPwwYI3CK55wOKAg==
X-Google-Smtp-Source: AGRyM1vfkeY+2sNWBGKwGVP7hredO5XrIUgro7IiA9rXKlkfozb5qjNIiPacAEm5mWk+33NBN/Bc2Iim/3d2sohBOe8=
X-Received: by 2002:a25:946:0:b0:670:ccc5:774a with SMTP id
 u6-20020a250946000000b00670ccc5774amr8877682ybm.381.1658757245546; Mon, 25
 Jul 2022 06:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220725133208.432176-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 25 Jul 2022 22:53:54 +0900
Message-ID: <CAMZ6RqKw1NC1ZHcXDW3mWPzQedUiwPTRXOCtdgNEnsW0eBcY=g@mail.gmail.com>
Subject: Re: [PATCH v1 00/24] can: add ethtool support and reporting of
 timestamping capabilities
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Stephane Grosjean <s.grosjean@peak-system.com>,
        Jimmy Assarsson <extja@kvaser.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sun. 25 Jul. 2022 at 22:32, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> This series revolves around ethtool and timestamping. Its ultimate
> goal is that the timestamping implementation within socketCAN meets
> the specification of other network drivers in the kernel. This way,
> tcpdump or other tools derived from libpcap can be used to do
> timestamping on CAN devices.

For those of you who would like to test it, please have a look at the
other series I just sent:
https://lore.kernel.org/linux-can/20220725134345.432367-1-mailhol.vincent@wanadoo.fr/T/

@Marc, this is a long series (25 patches but many trivial ones) just
one week before the merge windows. Overall, I have a good confidence
on this series, except for the last four patches:
  can: kvaser_pciefd: advertise timestamping capabilities and add ioctl support
  can: kvaser_usb: advertise timestamping capabilities and add ioctl support
  can: peak_canfd: advertise timestamping capabilities and add ioctl support
  can: peak_usb: advertise timestamping capabilities and add ioctl support

For those last four patches, I would like to get the feedback from
Jimmy and Stéphane before it gets merged. If additional time is needed
for testing, it might be wise to just merge the first 21 patches and
leave those last 4 ones for the next cycle.

Yours sincerely,
Vincent Mailhol
