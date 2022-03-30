Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733E44EBA8D
	for <lists+linux-can@lfdr.de>; Wed, 30 Mar 2022 08:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiC3GFm (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Mar 2022 02:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiC3GFl (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Mar 2022 02:05:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224212A82
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 23:03:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso14275788otp.4
        for <linux-can@vger.kernel.org>; Tue, 29 Mar 2022 23:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aq+OzWeIFRkkRRT07IOL6fpDOZAN+0UpnNUMJ10opGo=;
        b=rcuU5GSO/p4ngC1HW0OS3dKNLYvVwSlavLvaBVYLVcoY2QdTvoiJCS2gFLFa4Jgz//
         UXnnWqWobQ1J1oaUfgKY1IhAkXe/v4SWv5uGBjBC++yX7QpZLcdKdmDS7JLjxgFK2XHy
         QlcDUQuWjqjooNv9+Nm8h/8vm5deaQHDIhQgamxddB+hrW5GuLGgBu5uA+kfzlEadqZD
         XV+/r+ZnSGU1VlblVt1btHFEUkS7K4KpJdM4ki4WXwdQyZxrwolgDMumOZwqYS/oWh6D
         sADdeMIwYQa85hV6kf0ieQQyk2gKDLlrFdYuMbORd43RGmbu2S5lfvhKGSXbEJxfEaN1
         R/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aq+OzWeIFRkkRRT07IOL6fpDOZAN+0UpnNUMJ10opGo=;
        b=cYbw8xTC+E7kjSNKkqj0QGiBbgavILQ6uXMywGlWeq/1zhGenHrahV0yRstZd49JQ/
         4BnQe4d5JAxWNmovLvrI+X99iKTlxwcY7IpKm9Giz85bNEODOEm7cpSXRyFhXHss3qGJ
         WGD1Zso6QTjez5/jxvfs67hi/nblRgS3inXaSv0FFZPMOAijCKdBNrPwoq+8TKK5ElQD
         IXL3tVOHzXKmYYmxAJ+AbIcm4a0DFMOoI0NJ1p+6XAOzWwnOrxSrw6YgcKoK4++Wesjk
         0hu8a96DwWMfFcokjtc/7mCxvq7pcJcGmRVqDz+mM+0Tx3f2p4qZWx0E1gxADkQN4UjI
         OK7A==
X-Gm-Message-State: AOAM5323ctWIMLHpTZCVOo40pLa6pu16sbY1zHfb/gLnv2wTbwQJZ1v3
        VS0Bd3zPkpPyW/YHAW+g+wV6MMOMxHDUQvwH7TNP5w==
X-Google-Smtp-Source: ABdhPJyuufzWhLHE6tJFTxrkg49Qd+LCgw6pvVMKdQBsc6AbpalZGrOCQLCdeOBA00Sb+fFBCx87aYD0JH1+gPKPnAw=
X-Received: by 2002:a05:6830:23b6:b0:5b2:4ac0:9130 with SMTP id
 m22-20020a05683023b600b005b24ac09130mr2628580ots.196.1648620231635; Tue, 29
 Mar 2022 23:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR11MB588040F5F12E2E4A3432583CDA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <000000000000f3087f05db668ff8@google.com>
In-Reply-To: <000000000000f3087f05db668ff8@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 30 Mar 2022 08:03:39 +0200
Message-ID: <CACT4Y+b0viS3dSbHvV3_O6gPpOw+1qqJeYh1sCChhj3CmaZuaA@mail.gmail.com>
Subject: Re: [syzbot] memory leak in gs_usb_probe
To:     syzbot <syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com>
Cc:     linux-can@vger.kernel.org, qiang1.zhang@intel.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 30 Mar 2022 at 04:47, syzbot
<syzbot+4d0ae90a195b269f102d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file drivers/net/can/usb/gs_usb.c
> patch: **** unexpected end of file in patch

Hi Zhang,

It seems that your mail client messes up whitespaces and breaks patches,
you may attach the patch as an attachment then, it's more reliable.


>
> Tested on:
>
> commit:         c2528a0c Add linux-next specific files for 20220329
> git tree:       linux-next
> dashboard link: https://syzkaller.appspot.com/bug?extid=4d0ae90a195b269f102d
> compiler:
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dc8777700000
