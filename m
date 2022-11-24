Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983F36378F0
	for <lists+linux-can@lfdr.de>; Thu, 24 Nov 2022 13:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXMc1 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Nov 2022 07:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXMc0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Nov 2022 07:32:26 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873084664D
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 04:32:25 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id v82so1438254oib.4
        for <linux-can@vger.kernel.org>; Thu, 24 Nov 2022 04:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gxFYgcxzTf4yWUQxNFfTjoRgkYEcmk85GLRkZVTrkVk=;
        b=UjheQD2M5sP0/TzX/PAlnVPtV4TiP4TgYJIGUQrr86ZSgDfwaAObTTvYC9ABOwwg1d
         KadDxbdawUchdxxMYfwkvkZ+S8t5W9wfUMkx0S1xcPW5TubDuGrPpnk1ZttXUNzOoFBH
         arbSfG9OmSrvLaDqEnbHKftzQfcEdWG2ExNcvWxsEUOWUqJGdxdnouMufFOSdYqu8Ilz
         0HIn8h7U6NKjwzgVQlFNs2BHCjlNBv76vkzgDagQINCIcaE4tE4RYvPolIXIH30KmXcc
         IN84fFcY3TqtevsVkJRCgu4VA0V2zGdNz60KPPRFN17zA8BBsU5Q7bqIEiefVLhgL01R
         C6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxFYgcxzTf4yWUQxNFfTjoRgkYEcmk85GLRkZVTrkVk=;
        b=GzPg6CW+nnCB7b4irH4ZI+fGv+hPMVbXKE6Y20N8GPGTJq50gO5Cf+Xj/j53HvxQyv
         X2e2w0F0wn0DjTEakqvO62LMC7+4GKOjYZ8vf3tNQIUabe6OXvnrtnPKLCoqf4lAvd1o
         oWPV6bc7E+m4jpXOiSmpMAf8PUQv7dS3BDTigG/fiHv/Z86mkZ/t5UlBnRWPTN3OIKbm
         vySLbensYQ226FHTxJmvga0os9v+SuiMIWRyoAPlegzJ/l6aKfoO93DoSWYemJjkh4O9
         RjaJ5DePoeFAzpbVwWL2UOHR3fm/1S8PuZNZRt3Xh18ya6yupk8MP0yQdnAaVUYYLP5P
         qC0g==
X-Gm-Message-State: ANoB5plDRQQgTgk+rX8xwcTLutpGUQaJ9SqCU17yp56KoDzyPa3m9Mo3
        iN4O6uWBCSwCltoHibDwDN62zyMn4YfLeG5KeVc5+g==
X-Google-Smtp-Source: AA0mqf7Dqv2ZXKjPTz3QOr01ckQ/fZsaXczkQdOqw/6GNEGRpJv18SSKIL3U9FA+IvAcAd+5dXzJJyjAkHKGRYmbKpg=
X-Received: by 2002:aca:e082:0:b0:35a:4069:85d8 with SMTP id
 x124-20020acae082000000b0035a406985d8mr19038211oig.101.1669293144946; Thu, 24
 Nov 2022 04:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20221123194406.80575-1-yashi@spacecubics.com> <20221123223410.sg2ixkaqg4dpe7ew@pengutronix.de>
 <CAELBRWJoQjLD9UaFUmqnFWT9HkPMNb4kKF+1EZwcfrn_WBwBYw@mail.gmail.com> <5a309931-ca81-5433-b437-5c8ec23c4d85@hartkopp.net>
In-Reply-To: <5a309931-ca81-5433-b437-5c8ec23c4d85@hartkopp.net>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Thu, 24 Nov 2022 21:32:14 +0900
Message-ID: <CAGLTpn+EdkVXUNvRCa1-jwcpm=Hu6t+87HKUYdVJDWUZ+U194g@mail.gmail.com>
Subject: Re: [PATCH] can: mcba_usb: Fix termination command argument
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Yasushi SHOJI <yasushi.shoji@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        =?UTF-8?B?UmVtaWdpdXN6IEtvxYLFgsSFdGFq?= 
        <remigiusz.kollataj@mobica.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi

On Thu, Nov 24, 2022 at 7:09 PM Oliver Hartkopp <socketcan@hartkopp.net> wrote:
> What does "termination 0" mean here?
>
> I assumed "termination 0" results in "termination off" (=> no
> termination => very high resistor value) but in fact it gets around 20
> Ohms, which is a pretty heavy termination for a CAN bus.

[ termination { 0..65535 } ]  is what we get when you run
ip link help can

And include/uapi/linux/can/netlink.h states that

/* u16 termination range: 1..65535 Ohms */
#define CAN_TERMINATION_DISABLED 0
-- 
            yashi
