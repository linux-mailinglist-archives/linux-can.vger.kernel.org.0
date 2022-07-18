Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC67577BE8
	for <lists+linux-can@lfdr.de>; Mon, 18 Jul 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGRGwg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 18 Jul 2022 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiGRGwf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 18 Jul 2022 02:52:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FB9E0F9
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 23:52:33 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u13so17762791lfn.5
        for <linux-can@vger.kernel.org>; Sun, 17 Jul 2022 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1K60Xg4y6Z1QZves6P/cs+d8jxDHB1v8TOqYQyRQIk=;
        b=dRaNYZOxKTEtSkD1EF5s3uP28KqPZa9eWCHPYSxs6n2DYua3SY/gAiVFVjRvZiBKcj
         3A95Zi0e6sMpaw7+VQjRCBJ2yLOTdjyz/M3w8BrY4b+MXdnDsH6W5K20U7u1kE9vtLXT
         uXApbVDsGBAE1vNTPwzRSp4o6RD3CGPG23gqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1K60Xg4y6Z1QZves6P/cs+d8jxDHB1v8TOqYQyRQIk=;
        b=u1mi4vAhssPPmq7HIH7MdI8ta9u7LULouQ7rMwJWL5SQcUVTG898NKk53Uym9t8E3e
         HRb1kA0Z5MnIItOrW/aKbYUKkzpOULdErVv1SLPRhxVeBI8oLtkjc+xJxe3Hms3APRu2
         Pdty0C0MXoeglAP8eNk2tEjNuMV1NHAj6oM/xOIetwKeAcPo9lKunZetXiRQHcal+tpi
         QK0WE+KbU97gpzkL+0jKC4xsd1inaQUc+us3fhzUsqRqol/MOELIuOqmRaNCgZWzEnBc
         RsUnRnCsLhtZkgTzr2FnfEUhYMI0hVhykKFdGBFajHi6wtIFwYpPVzENaAaKo4zdkTli
         MfwA==
X-Gm-Message-State: AJIora/ZehYnZkP5y5icc902KosUAyjdcGpyveEvEXLxlHAW++oNRWJX
        3TX2ZA5dg1sV+DSR2pCLbFqdXxDHFnvpI+dzE0dhCqZeLpTS2A==
X-Google-Smtp-Source: AGRyM1sj/sMUQHGENTj9KaUyJbHpvZqcrJ7OYo6RBWj8v2BkpNn3Zvoca88CAVu6SGMaq0GgbQqjsLsQppnM9eh9qW0=
X-Received: by 2002:a05:6512:3ca2:b0:48a:7f7:3a20 with SMTP id
 h34-20020a0565123ca200b0048a07f73a20mr14416566lfv.153.1658127152316; Sun, 17
 Jul 2022 23:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <62cf77c3.3T/sxYUjJq0ImGp4%lkp@intel.com> <2d6d9627-bc98-07e9-dbcb-5f317913f5aa@hartkopp.net>
In-Reply-To: <2d6d9627-bc98-07e9-dbcb-5f317913f5aa@hartkopp.net>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Mon, 18 Jul 2022 08:52:21 +0200
Message-ID: <CABGWkvqNSgweoLoeOwhEdz27pqYVBH32TLTeEwNRiXhncUeB3g@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION 4662b7adea50bb62e993a67f611f3be625d3df0d
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Oliver,

On Sun, Jul 17, 2022 at 3:58 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
>
> Hi Dario,
>
> did you see this build regression too?
>
> On 14.07.22 03:56, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > branch HEAD: 4662b7adea50bb62e993a67f611f3be625d3df0d  Add linux-next specific files for 20220713
> >
> > Error/Warning reports:
>
> (..)
>
> > drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void *
> > drivers/net/can/slcan/slcan-core.c:601:14: sparse:    void [noderef] __rcu *
> > drivers/net/can/slcan/slcan-core.c:601:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
>

IMHO I think that adding '__rcu' annotation would remove the warning:

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7b0a5d478ef6..278b84f04d20 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -239,7 +239,7 @@ struct tty_struct {
        wait_queue_head_t write_wait;
        wait_queue_head_t read_wait;
        struct work_struct hangup_work;
-       void *disc_data;
+       void __rcu *disc_data;
        void *driver_data;
        spinlock_t files_lock;
        struct list_head tty_files;

But in the paragraph "SPARSE CHECKING OF RCU-PROTECTED POINTERS" of
Documentation/RCU/rcu_dereference.rst
we read:
...
Unfortunately, these sorts of bugs can be extremely hard to spot during
review.  This is where the sparse tool comes into play, along with the
"__rcu" marker.  If you mark a pointer declaration, whether in a structure
or as a formal parameter, with "__rcu", which tells sparse to complain if
this pointer is accessed directly.  It will also cause sparse to complain
if a pointer not marked with "__rcu" is accessed using rcu_dereference()
and friends.
...
Use of "__rcu" is opt-in.  If you choose not to use it, then you should
ignore the sparse warnings.
...

So, I think that by adding the '__rcu' annotation we would have new
warnings in all those points
where disc_data is accessed directly (which are many more than those
where rcu_dereference() is used).

If I'm not mistaken, the warning also refers to code that my series
hasn't touched. Also, in the 'BUILD REGRESSION'
report, the slcan warning is found under the 'Unverified Error /
Warning (likely false positive, please contact us if interested)'
section.

So, can it be okay to think about leaving everything as it is, and
then not apply any patches to remove this warning?

Thanks and regards,
Dario

> Do you take care on this one?
>
> https://lore.kernel.org/linux-can/20220717025703.pcrf6bseaigsq22r@revolver/T/#m54028de8868a0f653294f6a272a9094378a1cdd7
>
> Best regards,
> Oliver



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
