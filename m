Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039B1326558
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 17:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBZQPg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 11:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZQPd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 11:15:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736CC06174A
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 08:14:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b3so9102912wrj.5
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 08:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PgumST9E2sDt6UmaQJ3JZE/OHkq062TpQ7qtimhu4qs=;
        b=XKF19MhZV3mwsEafvIo2xQf9IApNtlJMbBOO/UnC4frv69esRGzpKppv0zuhdz2TvZ
         hGIHuozzC9OX8rQzdpgJlDwYhsiAxyV/z/dzOaMmJ+R4S8xOr7JqI3lhmv9sLwliyJ/1
         X4bUQSIbtGwn7DDB9GSqN3QRif5kGTE33YiHXzGt+mKX4dYox/zuqZpPQ+AC5AsjWodY
         WvtVUq/1x2mQRa/8eoexxvwR2MDtUyftSBsIHZkoJoo2Ons4M2iFYoXvqUFNBfX3Nu4e
         bI16+StTbzSOBn617I0VNeqx8EXpKqWCpw+fC5fHrosFJEyVhU8h8VV0aYNW4fANk8En
         +jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PgumST9E2sDt6UmaQJ3JZE/OHkq062TpQ7qtimhu4qs=;
        b=O9J2eOfKixD1vkrVe4Si0kmVn37Fs1koPVHXmDL9Ra+7ARQ8HJFMMVHDDpY/g44Vot
         m7rlFSra7s+RJrtmbm8fVN4gXu/affZ6m1xXSegVbPK7QRPSZvCucOBTkrmFw56Ih2dc
         p3CRCAdS/0I8tLTHfLHmUtLI3hv2dagmSDyphCCMidqg8uKJplhblOLbkA7vhfdtAd7R
         5X1iPTTysGhRQmGfZ+ikt1ozqF0IgH0pg4SPyU+Hn0qRvqRdjy7DBthbLPo+TkvcO7cB
         zBlsgc2oM6MOHGo1ese6MFAK7STgfKIxvXudfzE/FrxkYXkq6Bvg/7hDxn/Kp6+TGaKG
         BGyg==
X-Gm-Message-State: AOAM532tvVtcXXNXc3+d4SKp3jNIj9zbLSUC7Ss8nldAXPB6UOklwuWS
        7pmbyb8DzTCwcJ1y3Qn9lX2NJA==
X-Google-Smtp-Source: ABdhPJw1fIDJECyrbn15CB0HlmYEWaOfWEzK2MYlJZb+lCxulUN0d4VfDZ+yqvbuK0GnOOZXzRK2Ow==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr4044749wrw.343.1614356076218;
        Fri, 26 Feb 2021 08:14:36 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id b131sm3216418wmb.34.2021.02.26.08.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:14:35 -0800 (PST)
Date:   Fri, 26 Feb 2021 16:14:34 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226161434.ymdrmclic6nrccj5@bigthink>
References: <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
 <20210226132620.wfuvywkzmhwfmhpc@bigthink>
 <20210226133936.q3o7hrshyurhj3ke@pengutronix.de>
 <20210226134522.kd3oxtx3u4ltjxos@bigthink>
 <20210226140054.725kihkdgkmtl3xf@pengutronix.de>
 <20210226152633.dkro7ffhye4c72hb@bigthink>
 <20210226160135.w43onb3z25xhv4re@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226160135.w43onb3z25xhv4re@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Feb 26, 2021 at 05:01:35PM +0100, Marc Kleine-Budde wrote:
> > Is timestamp-wrapping a concern for rx-offloading?
> 
> No, as long as you provide a proper u32 timestamp, which means wrap
> around at 0xffffffff to 0x0. As the tcan4x5x has only a 16 bit
> timestamp, shift it to full 32 bit, like this:
> 
> https://elixir.bootlin.com/linux/v5.11/source/drivers/net/can/flexcan.c#L805
> 
> On the mcp with true 32 bit timestamp there's a wraparound every 107
> seconds at 40 MHz external clock (0xffffffff / 40000000).
> 
> The tcan has the TSS.TCP as a prescaler and increments in bit time,
> which is 5MHz max. This results in a wrap around every 13ms (0xffff /
> 5000000) with a prescaler of 1. With a prescaler of 16, you can increase
> this to 209ms (0xffff / 5000000 * 16), which gives an accuracy of 2
> bytes.

Nice, thank you, that all sounds good. I'll get to work. :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

