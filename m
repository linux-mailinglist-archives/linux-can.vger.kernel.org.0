Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36804C000E
	for <lists+linux-can@lfdr.de>; Tue, 22 Feb 2022 18:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbiBVRYE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 22 Feb 2022 12:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBVRYD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 22 Feb 2022 12:24:03 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A6416EAB0
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 09:23:35 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w2so528198pfu.11
        for <linux-can@vger.kernel.org>; Tue, 22 Feb 2022 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nv4qAqRv9W6XZtCmkuUEmQ/xRudodwIixYPxs8ChXQw=;
        b=hvDjAS0+CGLcwoU82nqSUa9z96uK+sHGK5bbwWd3+ZQF4xK1LLHVi+MdzLej/ezrI5
         xl+7Q7QCvL/Rx7MAL776nVTdm9u9XwZ/TGmzzo1X4bwTqDkTutwcO/g8reB6HBpcid39
         dcfeQtGPhTVWiqSjziovI6NfpbjRQuZVGSC6CQwLjwKlAn1OyjkeGDCajUpQ/OzZelTw
         2w0NvXBkeqNUwRzWcZJbldNyAn1+8c2L0hKQ0pyv/KIVbAktmFjNju7FZuEtVN/34sjf
         Uf4o5QXVH1fAg8aWUZS3uh/3/TR6FGCfFIQk2fhrHBxbFinYRQC0wd1uDk/xd6WsoChr
         3W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nv4qAqRv9W6XZtCmkuUEmQ/xRudodwIixYPxs8ChXQw=;
        b=yjcwokJuLRzd6f8F0BGXZuctHb2/NePMlTGS3vajsgXakEDBAwWX4b6MAUl85L4LB5
         3dRTFvpk3c8DMCa8ZCM/3ovuF+QDaGvIQhhRk6dAFalNiCWQ8GHMU59pXalIFfUrVSJp
         Y9QMpw2eWgIl101AXY39xxaUrmRvNI0MAIb6QHagGQ3puLabSynqIDeC2AO4Ot3AvoCt
         hVjcw9YJlQ25+9D6WD7KqL4aOVXo9E8xhL8ymT770u1i3v9zlqVPY25wPtS5a2Djd9Mx
         LpsUWGo6sp9kTZIB7AGrvJQ8UvWcc7gd4V1AwUnmnSo4sfjcah4E4kJevw+xZ4uHnQjp
         GVrA==
X-Gm-Message-State: AOAM530iX4kfbz1J+91mBoxmkxKha7HL92eDfRBG0CCb3PlYQtFvmhjK
        XS9eft7QDdomembOHic4/0Eshend++2Vnq5/btIfLFvv2EFYT8AUafs=
X-Google-Smtp-Source: ABdhPJz/J/02MWkTvQ1GRPmLey5Ee6InBPO2jbi804wP0tcpsFLKst/6m/V3jXR61YruPxxdl74YOaa9PHzx5Ay+I7g=
X-Received: by 2002:a05:6a00:22cc:b0:4e0:58dc:e489 with SMTP id
 f12-20020a056a0022cc00b004e058dce489mr25725454pfj.58.1645550614479; Tue, 22
 Feb 2022 09:23:34 -0800 (PST)
MIME-Version: 1.0
References: <CANsTw8pbmOcHecJ-aVBhN6gHmmYmTVPOun0BqgfktZ=CyWGzOA@mail.gmail.com>
 <20220222154237.hkie7wcgl5ng7aof@pengutronix.de>
In-Reply-To: <20220222154237.hkie7wcgl5ng7aof@pengutronix.de>
From:   Matheus Eduardo Garbelini <mgarbelix@gmail.com>
Date:   Wed, 23 Feb 2022 01:23:23 +0800
Message-ID: <CANsTw8qN=fr6C0xPussidY_gy7-nG0JrEfyAKaohD4PnwTqCWg@mail.gmail.com>
Subject: Re: Looking for CAN FD sample captures for socket-can hardware
 integration testing
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

Thanks for your response and suggestions.

Yes, I'm afraid a real CAN FD traffic of a real car is still desirable
to our team. This is normally a trace file (.csv or .txt) with raw
data and timestamp (i.e., equivalent to .pcapng wireshark protocol
captures).
The idea is to mimic real components on a real CAN FD testbed that
uses a CAN FD controller implemented in a FPGA controller (CTU CAN
FD).
The characteristics of a real CAN FD traffic is valuable for research
since we don't have access to a real car with CAN FD to test with.

Regards.

On Tue, 22 Feb 2022 at 23:42, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 22.02.2022 22:21:36, Matheus Eduardo Garbelini wrote:
> > I'm not sure if this is the right place to ask this, but I'm looking
> > for some sample CAN FD captures to test different socketcan
> > configurations in a real testbed.
>
> In the github discussion
> https://github.com/jgressmann/supercan/discussions/7 you specifically
> asked for a capture of CAN-FD traffic in a car.
>
> Is this still relevant for you?
>
> > There is a lot of CAN FD hardware already available, but I could not
> > find on the web any FD sample capture on the matter. Would appreciate
> > it if anyone could share or point me to the direction on where to find
> > CAN FD sample databases as reference for socketcan testing and FD
> > frame simulation.
>
> I don't have a car and usually don't have access to our customers real
> CAN(-FD) environment. For testing I use the cangen tool of can-utils.
>
> | https://github.com/linux-can/can-utils/blob/master/cangen.c
>
> You can generate CAN-FD frames with certain length, payloads, gap
> between frames and other parameters. For stress testing I use a
> combination of cangen or cansequence to send and cansequence to receive,
> another good tool is canfdtest (doing a full duplex test). Although both
> tools (cansequence and canfdtest) cannot send CAN-FD frames yet.
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Com os melhores cumprimentos,

Matheus Eduardo
