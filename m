Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797957B1AC
	for <lists+linux-can@lfdr.de>; Wed, 20 Jul 2022 09:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiGTHYv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 20 Jul 2022 03:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiGTHYr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 20 Jul 2022 03:24:47 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A867C89
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 00:24:47 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r3so30704794ybr.6
        for <linux-can@vger.kernel.org>; Wed, 20 Jul 2022 00:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e11+fe8Z8ESHsJuUn0fkECgkggAo1cSJFgG5j15LV7o=;
        b=MURAn5IFG1unHBbu6LcNSnF7xIZA7Jq+UJPx2oZb2k1Ks7l+pEr48xQdE/UEFl2SYD
         +lOQ5uIZMty/dOftDrQoBlnG8GTQSRVj0Grb+r8fcIzImiyikYow6KC+Z2skBhqF+qK2
         yzvX+/0aG5PZuMLv5CwunoHdILLpq9pj7aM89W7d66IaP9giLSnvuYFu/W83HeyZ9fLv
         H6RgL7Fsp2RSMRtjZhEkOE9fSh3r1wUoT08aEN24mASIav35O67TZVacEXePXU2QlN6m
         aDJjB6yiM8r19FeGNyTi+HEBl2vHPc8mggPhElDgNsfbt+bbvM9I9efN2tK2MhEUljVJ
         pJ8A==
X-Gm-Message-State: AJIora9yZHS34KHhCtfZGa7WL768lV1GIyVmm9ER6AtSwCMrepXUL0qj
        vW/apiYcWRbH6vGSLDLlS+brw/24OOvforxA68l2MWVX
X-Google-Smtp-Source: AGRyM1tSzrbZvVkF4DJP1e0rGDMfeEFmX6tRbgVPNtt+mFOSgLXHHy/8Pheu5ZKtmz4sinfxCy1U7jKQb3nhRXoTAeA=
X-Received: by 2002:a25:a0cf:0:b0:66f:f075:51cb with SMTP id
 i15-20020a25a0cf000000b0066ff07551cbmr23222728ybm.142.1658301886333; Wed, 20
 Jul 2022 00:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220719143550.3681-1-mailhol.vincent@wanadoo.fr> <20220720071717.q7egrzu2fjc2c64i@pengutronix.de>
In-Reply-To: <20220720071717.q7egrzu2fjc2c64i@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 20 Jul 2022 16:24:32 +0900
Message-ID: <CAMZ6RqJ+HnkzLxLkgZMqKmFGtXJR9udD6ak+JnFs4AYD1HCyKw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] can: error: set of fixes and improvement on
 txerr and rxerr reporting
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Frank Jungclaus <frank.jungclaus@esd.eu>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <Stefan.Maetje@esd.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed. 20 Jul. 2022 at 16:20, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 19.07.2022 23:35:38, Vincent Mailhol wrote:
> > This series is a collection of patches targeting the CAN error
> > counter. The series is split in three blocks (with small relation to
> > each other).
> >
> > Several drivers uses the data[6] and data[7] fields (both of type u8)
> > of the CAN error frame to report those values. However, the maximum
> > size an u8 can hold is 255 and the error counter can exceed this value
> > if bus-off status occurs. As such, the first nine patches of this
> > series make sure that no drivers try to report txerr or rxerr through
> > the CAN error frame when bus-off status is reached.
> >
> > can_frame::data[5..7] are defined as being "controller
> > specific". Controller specific behaviors are not something desirable
> > (portability issue...) The tenth patch of this series specifies how
> > can_frame::data[5..7] should be use and remove any "controller
> > specific" freedom. The eleventh patch adds a flag to notify though
> > can_frame::can_id that data[6..7] were populated (in order to be
> > consistent with other fields).
> >
> > Finally, the twelfth and last patch add three macro values to specify
> > the different error counter threshold with so far was hard-coded as
> > magic numbers in the drivers.
> >
> > N.B.:
> >   * patches 1 to 10 are for net (stable).
> >   * patches 11 and 12 are for net-next (but depends on patches 1 to 10).
>
> IMHO the patches 1..10 are not so critical that they need to go upstream
> via net. Especially that we're already at -rc7. I'll take all via
> can-next, OK?

Absolutely OK. Nothing critical here.
