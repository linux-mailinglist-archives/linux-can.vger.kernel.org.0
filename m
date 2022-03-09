Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE51A4D26B3
	for <lists+linux-can@lfdr.de>; Wed,  9 Mar 2022 05:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiCIDAC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Mar 2022 22:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiCIDAC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Mar 2022 22:00:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E5134DE0
        for <linux-can@vger.kernel.org>; Tue,  8 Mar 2022 18:59:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso4019155pjb.0
        for <linux-can@vger.kernel.org>; Tue, 08 Mar 2022 18:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g5MHqhyRAvMJEIygnpqs4s9C8dwI28dlr5hbuf+tGdY=;
        b=w45iZX907cG/aaBaR/56rFZNCTIi99WnfB+0ACkYqOiNvywwJF0JgdbOQg7Z6KsLfe
         Z8b2IizBvB0OE3LcnE+yNWFkrk7zhyHvs936KLO1kk6KR+rXPDmWHrtIIwCBkkmp0Kou
         f4NOP7/Utuq9x75690VJOtL7Q4s9uTpYESLYsH6tBUHxf/oUQas1IcJUPnPJZ9tXwMJZ
         n8GoQDnEn0P7Xj1vXaffjsouIqStgDoeO1p1D2aNn/18QlE3OiGes5uZzPBU6UWWDiNr
         BZPZzzIsVgzpEpY8bmDff8kIQrc+VRAjSBbbnIZizwfrC80r0SVVotYm4tpSLVABtbvu
         bKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5MHqhyRAvMJEIygnpqs4s9C8dwI28dlr5hbuf+tGdY=;
        b=GJ2UVtwnlZUA+HPrka9wT8QXpGLNUT63vmLpWJJxyys1E1QvGj7BHe4BFNtK6wriw8
         TGTbdpmeWe5sL3M1T7BIULLTdn4qXGLLivVRgQbGLZ82kg5sfkU5D3mUHY7ANmnSBqk8
         2XNjW1ZQ4N/q7UzNJACxvVKy2VQLkflCtUXjAQHVbrFZFeXjR9CfNE/q14PTbUtHgAuE
         XHZiGqFrObpBM2b7/5VuY0XRyZxuUD+ELdx37+SwCAYdsiG81SIhAjCu4IfPdViiprrl
         cFcLfasoKxi98zoeIYblu6mirAJm4DC+9rfvmjlBIQhSwgPPq0nG6UBZDKO+VGoco9MM
         Nz5g==
X-Gm-Message-State: AOAM531sAukBr63xDWN3MAP0z3SsTHZrP9s851Smrlt3Cqbxj34AO41A
        nHVItWizaK6JifLHnzcYKtc8Kfx5pixcR0MwQIp9ow==
X-Google-Smtp-Source: ABdhPJx6gIuB0ETKC5IdKG3N0AifUmdKV55gnSE4Xr4Buukiwf3ar64hKVfVW22ZPivJHacPqRfEJMAPvffMOT9QvXI=
X-Received: by 2002:a17:903:2c7:b0:14f:fc47:5a2f with SMTP id
 s7-20020a17090302c700b0014ffc475a2fmr20654160plk.112.1646794743333; Tue, 08
 Mar 2022 18:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20220307185314.11228-1-paskripkin@gmail.com> <CAMZ6RqKEALqGSh-tr_jTbQWca0wHK7t96yR3N-r625pbM4cUSw@mail.gmail.com>
 <52da93cd-6a78-1b77-6a86-c338c7cb11e9@gmail.com>
In-Reply-To: <52da93cd-6a78-1b77-6a86-c338c7cb11e9@gmail.com>
From:   Yasushi SHOJI <yashi@spacecubics.com>
Date:   Wed, 9 Mar 2022 11:58:52 +0900
Message-ID: <CAGLTpn+p=bJUe14qpP664JMY9_xKTr5UQ3bEmpiOXFvK5S3prg@mail.gmail.com>
Subject: Re: [PATCH RFT] can: mcba_usb: properly check endpoint type
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-can <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        syzbot+3bc1dce0cc0052d60fde@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Pavel,

On Tue, Mar 8, 2022 at 5:06 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> On 3/8/22 03:23, Vincent MAILHOL wrote:
> >> [PATCH RFT] can: mcba_usb: properly check endpoint type
> > It is RFC, not RFT :)
> > I guess you went on some manual editing. Next time, you can just let
> > git add the tag for you by doing:
> > | git format-patch --rfc ...
> >
>
> I marked it as RFT, because I wanted someone to test it. But indeed with
> my lack of usb knowledge it should have been RFC :)

l didn't know RFT to mean "Request for Testing" :D

I have the device and do testing.  Do you have test code I can run?

Best Regards,
-- 
              yashi
