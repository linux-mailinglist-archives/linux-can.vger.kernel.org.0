Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28866456FA2
	for <lists+linux-can@lfdr.de>; Fri, 19 Nov 2021 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhKSNeE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 19 Nov 2021 08:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhKSNeD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 19 Nov 2021 08:34:03 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A19C061574
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:31:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id t26so43286278lfk.9
        for <linux-can@vger.kernel.org>; Fri, 19 Nov 2021 05:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RPO30W6OiQ3zNixWQZK1wVOKOoQFCIfOJaz2DxcAggc=;
        b=saqZeDMdvh2RPRedl+YH6Qm2YT4VfJ8eCfBsDsFIlft1uK933Iy59hBvK0ckP8W06m
         sk5dzsr7X8HoCJzyk2Y6xLZEeASzPv3Jdv6taMgnyLWs+IdC2YWRJTOaxCU3nxmKsYkU
         R1zCqo79I7n5CtYaUNAlU3OfnbFRwMIbXBJRW+ogT03DTJQ1ULrWPLyc4eZdEVLeU0GU
         e/UJtWiDXsKlRrua08EpYM0ol3noOlmEL/P/nDjlCpvJfYtsSRRS6UpRgeUodC+QdI8X
         oAb1NIdurzN/c77yHLiijojWLIw+D9PgPIF6k2PEFMgvOErYyPxVKFyxNENggWPdBjI+
         E3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RPO30W6OiQ3zNixWQZK1wVOKOoQFCIfOJaz2DxcAggc=;
        b=AFeonsCax9l9jalS6eRvF7rbEykH9CZNwMN1X8H43PxI0ldoONyaJj+LHaejqc3zMz
         FnNszRHcZU+3GTvFtU2PVi3Eq2uH+n2ucN00hts7xZ84yW0BItRuR4rLiHtAG8Oss/6t
         2WJdbhM0WHbUCTqfkUOOCtc3QO+mW/VA0fP2hamYC9lcZED/LNIdB6GuGMGlPM3dlDbG
         3DUHkTjrYK0fnQUj4suBucrpJCN7ygr9BOLRqk/XN9HKntSzUf1c+2+7HwzhQ62UAovL
         t/qvIeKYVMVxnya/ry3molMTNtTYE2WlipBTmUemKlxJnoFxUYZLftXVonG+wkci0dqo
         y+gg==
X-Gm-Message-State: AOAM533OG6LJt73jPomIkPuLSqgw5hpleLNuQbpNq2d3mwl0QPpf8jF5
        Rur9PkHqWweo5Q0y0Yi7K/mTuA==
X-Google-Smtp-Source: ABdhPJy+se2SR62Lh+Hv8CKIEHt17LaXHiU7M7H4PGV1nZAukZBQqlu4KFeN3Plx4NTS7V6ZQ03Dww==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr25262583lje.383.1637328659454;
        Fri, 19 Nov 2021 05:30:59 -0800 (PST)
Received: from [192.168.16.30] (h-155-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id o19sm402406lfk.280.2021.11.19.05.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 05:30:59 -0800 (PST)
Subject: Re: [PATCH v1 4/5] can: kvaser_usb: Use CAN_MHZ define in assignment
 of frequency
To:     linux-can@vger.kernel.org,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20211119131915.2033234-1-extja@kvaser.com>
 <20211119131915.2033234-5-extja@kvaser.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <90d2eddf-fcfb-0abf-2807-413b12480e8d@kvaser.com>
Date:   Fri, 19 Nov 2021 14:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211119131915.2033234-5-extja@kvaser.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-11-19 14:19, Jimmy Assarsson wrote:
> Use the CAN_MHZ define when assigning frequencies.

Maybe we should use the HZ_PER_MHZ define introduced in kernel 5.15 in
linux/units.h. It also got defines for KILO and MEGA, which we also got
in linux/can/bittiming.h.

What do you think?

...

>   static const struct kvaser_usb_dev_cfg kvaser_usb_hydra_dev_cfg_kcan = {
>   	.clock = {
> -		.freq = 80000000,
> +		.freq = 80 * CAN_MHZ,
>   	},
