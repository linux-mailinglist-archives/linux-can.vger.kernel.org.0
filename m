Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16D687CD7
	for <lists+linux-can@lfdr.de>; Thu,  2 Feb 2023 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjBBMFf (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 2 Feb 2023 07:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjBBMFf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 2 Feb 2023 07:05:35 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F0234F1
        for <linux-can@vger.kernel.org>; Thu,  2 Feb 2023 04:05:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 144so1003503pfv.11
        for <linux-can@vger.kernel.org>; Thu, 02 Feb 2023 04:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/jl/lMiwpSBMY+xly4nlRKIncWFHa0mIGwp+kAO2rc=;
        b=m7vb8dRnFMFUerFt6POyNiiNg63WcecbeopcUC/uRNuaUmMoyRMo0zFlWj+Myd/Tsz
         +j7rPckPdUgw7/58pta50UYbpvOeOg4S7qOguDBXjwmRi0gMvJOYUCkl2QYa3AAIow0O
         yumUfODwok0Z24Mpt2/yian8CZs3YaSes+GoUin89e3z3+JLrwSaRZGUVhvyQpCx++if
         hBkcLQySElKZOHtxVeGO2XeJ8UX0kYqdr3sSO/TPvsgEhIamd2ZnymF1Od9hF4jRpu8Q
         HZz+3648BSboazc3x58j2OVeimFJyqaqgHoRsxLI3nKDtaP8njs4p0vmTzBOpVGkrgcY
         /YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/jl/lMiwpSBMY+xly4nlRKIncWFHa0mIGwp+kAO2rc=;
        b=moBDXIjLD3oM7GP5C7MbWBI06chK8rB3M/8fgHx05oinXQ4DkT5wCQsjJwLtVMNKLf
         vZCaFFnFqBHJTBJ+6sdJkU3onDYdD7piupf5OHxsOISZZBklug0BoVwHZd3EJUnWxONO
         Vgtn3KzZaaJgLaaplZ/1Si6AModSZy4maPqv/wo807btZLqmnWK5NcUDHJ/uq8syJwjZ
         r3tYErFmIQM7Vtwk7VvGlHdhebq59182ECMFDZux/Mk5SAuiXUH/5GwUOEASWMn4Ko13
         LaqRxTcGDlEK4i0jcpP9WYU2htx2CQSpG0METtjTJ3rOXeS9wn5xQHzEo4UCEo6XbCDD
         77dw==
X-Gm-Message-State: AO0yUKWGo3GjWhSMVA5nsFQmFHBTMQvIH8gS5+fVla0UyZGDo99+biUq
        m2jy74eBUwkWt8WJS3SRZrOHKieScTM+3l+09NNHXStY
X-Google-Smtp-Source: AK7set+Wt9Xy1UrJKpSI/aeIqlzka1TFbWr35BsCCULUe54YhyNMYU4RZ5S36s/7xxbB4p/kVIDuFCRJrWmYTWTeYgQ=
X-Received: by 2002:aa7:959a:0:b0:592:a8af:4ffc with SMTP id
 z26-20020aa7959a000000b00592a8af4ffcmr1534661pfj.52.1675339533953; Thu, 02
 Feb 2023 04:05:33 -0800 (PST)
MIME-Version: 1.0
References: <20230202110854.2318594-1-mkl@pengutronix.de>
In-Reply-To: <20230202110854.2318594-1-mkl@pengutronix.de>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Thu, 2 Feb 2023 21:05:23 +0900
Message-ID: <CAMZ6Rq+LkkjBb+F8gfVCFcCJG4BU0aFTikvaZhR8TdYeEP8=hg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] can: bittiming: cleanups and rework SJW handling
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Thomas Kopp <thomas.kopp@microchip.com>,
        kernel@pengutronix.de, Mark Bath <mark@baggywrinkle.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I finished a first quick review and sent my nitpicks. Really great
work, thank you!

On Thu. 2 Feb 2023 at 20:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> Hello,
>
> several people noticed that on modern CAN controllers with wide bit
> timing registers the default SJW of 1 can result in unstable or no
> synchronization to the CAN network. See Patch 14/17 for details.

If this series addresses an actual issue, should it be backported to
stable branches?

> During review of v1 Vincent pointed out that the original code and the
> series doesn't always check user provided bit timing parameters,
> sometimes silently limits them and the return error values are not
> consistent.
>
> This series first cleans up some code in bittiming.c, replacing
> open-coded variants by macros or functions (Patches 1, 2).
>
> Patch 3 adds the missing assignment of the effective TQ if the
> interface is configured with low level timing parameters.
>
> Patch 4 is another code cleanup.
>
> Patches 5, 6 check the bit timing parameter during interface
> registration.
>
> Patch 7 adds a validation of the sample point.
>
> The patches 8-13 convert the error messages from netdev_err() to
> NL_SET_ERR_MSG_FMT, factor out the SJW handling from
> can_fixup_bittiming(), add checking and error messages for the
> individual limits and harmonize the error return values.
>
> Patch 14 changes the default SJW value from 1 to min(Phase Seg1, Phase
> Seg2 / 2).
>
> Patch 15 switches can_calc_bittiming() to use the new SJW handling.
>
> Patch 16 converts can_calc_bittiming() to NL_SET_ERR_MSG_FMT().
>
> And patch 16 adds a NL_SET_ERR_MSG_FMT() error message to
> can_validate_bitrate().
