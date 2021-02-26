Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83703262BE
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 13:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBZMc3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBZMc2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 07:32:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE5C061574
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 04:31:47 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o16so7654576wmh.0
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 04:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2+wKd98czlu7JQ4LvrmBdXSvupsv5g7JN3pks17x6sc=;
        b=vPAaP5ZliHHvWxja7AUsVWWywVWAFOeUDLS1xAuGLubUiGMkLTOzhefmS2J2mIrn2T
         i5YcPSoQG7Dtb9GQEhJXtAkmM3W/wyaOLOf88gAX4+F5Et0tErtCoYOI1zQZ+BD/4nW4
         Iw+k2e0W7Kc9im2zj+d/3MvzRaPcDAPxSXTjvSxbUVb4RVF7aD2pz6QsnyU3onJrCkXB
         AaMUktM1D90vFrMLyuGBNkf8sCwqGW18J5eyLop09CDNjFJ0jpUmyw2jE9fSgbhdds9N
         fM8SJgiAb4DVidLzy/0TvMvylXBODuaCBs/PUJFm7FpTQu4zKdhwpKfDsDy2NxUDdAqE
         3LhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2+wKd98czlu7JQ4LvrmBdXSvupsv5g7JN3pks17x6sc=;
        b=h1hwm3ooDreTczxgLuAoD+HaNivz94Oi8hsJGDbwBFIxlTobIO4uRP8+6kIRBieYwl
         mZqApYeO6jSCFbrI+S8wSqFMTtZ58S6TTCtCQE2wPGU6iPJ1tkLEjc0cOT1BWGx51+Kh
         22uzWgBwK1EIOI5p9mkDKLy6uUBw7yrxCZ3UNRzK92anO8ThgkvsAuC95Ff1IS0q7aUz
         6LA3hEAdxH8mmrnQ3ImGaz8kbcbQYjTaL/ia/BiC25gg7qya7dshHNxJsgr2j+BU3hOI
         Po+zKnQdqcOmNIarCpcL3ZIhxHmaWivVz9PEKEvkZeyJcwDl4Lbh4R0mgiqVEgqmU98f
         Orrg==
X-Gm-Message-State: AOAM5338rBIr8s43gIMRxcDiDwWBFxyKNA/Tk14nI6MIFMRsPq3Pu0wy
        nPhUe+U7O3HRt5mfV0G5yJnp2A==
X-Google-Smtp-Source: ABdhPJyiiZGX2mdqvp+675ZqtZZOsU0RUHeAeWyhKkLyF2HFqZXO7u3jm6O1o2rz3sLzgRS7QFjPZQ==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr2691073wma.18.1614342706623;
        Fri, 26 Feb 2021 04:31:46 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id q20sm11255896wmc.14.2021.02.26.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:31:46 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:31:44 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226123144.cwhjberqeyjctc6w@bigthink>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Feb 26, 2021 at 01:22:59PM +0100, Marc Kleine-Budde wrote:
> The problem is that netif_receive_skb(skb) is called from a threaded interrupt
> handler, but you should call it from NAPI.

Ah, I was sure it was in fact called from NAPI, but that's only if
is_peripheral is false. It should be as simple as getting rid of this
switch, then, no?

https://elixir.bootlin.com/linux/latest/source/drivers/net/can/m_can/m_can.c#L966

--
Regards,

Torin Cooper-Bennun
Software Engineer  | maxiluxsystems.com

