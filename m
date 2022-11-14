Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6306362758A
	for <lists+linux-can@lfdr.de>; Mon, 14 Nov 2022 06:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiKNFZy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Nov 2022 00:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiKNFZx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Nov 2022 00:25:53 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8CE38BB
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 21:25:53 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id o13so9340077pgu.7
        for <linux-can@vger.kernel.org>; Sun, 13 Nov 2022 21:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qyy7jP/htCSdrEJoCxty5Jy9j8heO6+8nvvs89yjW3k=;
        b=8RZ3lfXsU5GFp91v3bClGVFAhbUDxicGrD/gGOZDfMfQZSJFh5JpwyE964COCr8810
         zQBcxFXhTzL4SBqZNNU4pyBuaURKWTdX8og9Gd7xeCqZyjTyZEBxZU5QlbCEUiLHbbR9
         ygvw5sAXvsRi42ZuNpIsSNfsdl36CqvC9XWTtT0d6krMnSDhgyMSgFi2jThVLRjJAMc+
         Ef1lhaMFYsjxj7bzGgGCt3rB5nvQrP3rX/OdjQbuU6IO1Bh7CDrKoEp9JgusLt6ovUjW
         EZ65W4ObU1HMau8TVX9seouZVU1Unnhh1QdKppmje/9Pk7/hpeSF/uHrO3PFGrotovwh
         yMTg==
X-Gm-Message-State: ANoB5pnQ4M+t9dR66d8+CWAnwMO9VkW1Y/ya4UEDje6o4+SgYjf266gt
        ugYP/tKvg547+zZfLIzFD0yYJTmzz82Zj+tU2n4=
X-Google-Smtp-Source: AA0mqf7QDRQZKqsGcX+cgxM207MiQcSTZAVFVgmJLuItXlorygFGoKFJFOVxeb5CHVmtSY04zTcUXVz/GC0Q6Z8Boqw=
X-Received: by 2002:aa7:8759:0:b0:56b:a795:e99c with SMTP id
 g25-20020aa78759000000b0056ba795e99cmr12592646pfo.14.1668403552545; Sun, 13
 Nov 2022 21:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20221113085321.87910-1-mailhol.vincent@wanadoo.fr>
 <20221113085321.87910-5-mailhol.vincent@wanadoo.fr> <ff95c43d-d620-0301-06c4-2824f4c686f6@hartkopp.net>
In-Reply-To: <ff95c43d-d620-0301-06c4-2824f4c686f6@hartkopp.net>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 14 Nov 2022 14:25:41 +0900
Message-ID: <CAMZ6RqKVF6SS+eGK=bm16Q+LzitAdipchb2iPOH6c9MNo82prg@mail.gmail.com>
Subject: Re: [PATCH can-utils-dev 4/5] candump: use linux/net_tstamp.h instead
 of redefining values ourselves
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon. 14 Nov. 2022 at 05:05, Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> On 13.11.22 09:53, Vincent Mailhol wrote:
> > No need to redefine values when available in header.
> >
> > linux/net_tstamp.h is available since Linux 2.6.30 while socket CAN
> > was introduced in v2.6.25. These being old releases not being
> > maintained any more for many years, dropping support is
> > acceptable.
> >
> > Regardless, candump already relies on some other macros defined in
> > more recent kernel version (e.g. CAN_RAW_ERR_FILTER) meaning that it
> > would not build on old linux kernel environments.
>
> The patch is right but this text does not fit IMO.
>
> We have a copy of net_tstamp.h in this repository to make sure we can
> always build the latest binaries with the latest kernel APIs even on
> older development environments/kernels.

You are right. I missed the fact that there was a local copy of the
kernel headers at the include/linux/ directory at the root of the
project.

I will amend the description. I will also give a second thought on
patch 5/5: "lib: snprintf_can_error_frame: print counter errors if
CAN_ERR_CNT is set" as this one might have repercussions if built on a
new machine and run on an older one.


Yours sincerely,
Vincent Mailhol
