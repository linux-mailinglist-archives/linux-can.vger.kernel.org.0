Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD814AFB90
	for <lists+linux-can@lfdr.de>; Wed,  9 Feb 2022 19:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240756AbiBISre (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 9 Feb 2022 13:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241034AbiBISq2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 9 Feb 2022 13:46:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFB6C002738
        for <linux-can@vger.kernel.org>; Wed,  9 Feb 2022 10:43:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k60-20020a17090a4cc200b001b932781f3eso89906pjh.0
        for <linux-can@vger.kernel.org>; Wed, 09 Feb 2022 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+sONEBzAZg3zp1WHKYFoVg7NbwlcwZpxj5RNwbkdcU=;
        b=nakj85hA7k4QRgo/058/lXiysWUqHlG/o7xZQ/Pfy19pE5hQcbU1wI1eQ1Zodgx0ed
         krK12wxFjOcD7Ap5aWhR61Uqo0guUpvSjPWYJGGRSMl94OIN8GD/6XTxgyUTTOxI4Y+j
         Q8xAOCofbnvO/mqZG6sRnLrGxbpTHdgBGBiSrwb5j/lxallULMaazH9RkY6f6nbMjo1I
         0Ljk80sETka1X9tfmOob7PCoqQu3aUKlTg1bZMOikTvCycBGXtcekFamU2FhZ93MERh7
         uJBe8BpycnHpzUnNkuNbHx3zQb/F1Ta0gISWk+tXmNsMrH71DqXZas49H/Hrptizx3UN
         pF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+sONEBzAZg3zp1WHKYFoVg7NbwlcwZpxj5RNwbkdcU=;
        b=aduVsh0aPQJaIp0dqYeAzVkurE2Rcg3/S8C9s2SKDFysh1kN5nJZZ1gbMe4CC8kbYx
         EfrbEbM8VsK5O+z/YtfbOOhARuAO0Og7K4dzbWdmUP5xlHB0n1W6QeXpd9SzDUeE16C4
         7RC/PSlkEw7bn9G+qvc/RrX3ArDlbIV9f8dcYFmhD068nODAutW7+YJIo8XZ3XP2Llyu
         bVhIAlCgisISQd3CBhom6RpwK0CqWTngqk4Vp2ofRFU1CRdM/e/Ww6pNh6jTvJqP+cip
         xJ0hFr/Nm7RKj37kLM0Zwy0o2Ge+vYi3teXVkx0H5DG0glQYmZkiABGVZZX4hCT+CDwT
         NQzA==
X-Gm-Message-State: AOAM530I+1imtbQHoIQfMp5t2ON6mu5mVZZ8K7bvUqHBu58v3qLh0jaV
        z36gvthPy37n4cx+VlnmNrtvFQgjmTxBXWMKyqjaibBX
X-Google-Smtp-Source: ABdhPJxgLmWNvxDaL+L46uKcDx+MR3v9to9xINnNjO65S5U7kMBLL7Vi5M0uC+Jhd1FTOU+Q5LgzCH14ZP9Ij8ku84M=
X-Received: by 2002:a17:90b:1805:: with SMTP id lw5mr3963499pjb.219.1644432215167;
 Wed, 09 Feb 2022 10:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20220110082359.2019735-1-mkl@pengutronix.de>
In-Reply-To: <20220110082359.2019735-1-mkl@pengutronix.de>
From:   Brian Silverman <bsilver16384@gmail.com>
Date:   Wed, 9 Feb 2022 10:43:08 -0800
Message-ID: <CAP01z6LN3MeDjU8erzjYhuFBEOYr8vcLGUoMXeJuJLDgx+cYMQ@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update email address of Brian Silverman
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jan 10, 2022 at 12:24 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> please give me your Acked-by for this patch. This will map the old
> bluerivertech.com address to your private email address.

Oops, sorry, apparently my email settings aren't set up like I thought
so I missed this. Looks like it went ahead anyways, but for the
record:

Acked-by: Brian Silverman <bsilver16384@gmail.com>
