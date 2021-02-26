Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12B3262A4
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 13:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbhBZMUl (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 07:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhBZMTs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 07:19:48 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA32C061226
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 04:18:57 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p3so7284828wmc.2
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 04:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRakzkW9bryBlLcFYcmoInfM1jiRcffwSGQorT21Dhk=;
        b=AlloOZ9Lo5wIV4bOcEylIC+K/5u5GqBm4jWMacbqs2tIBztWv/2TfDc1P42tJQEvdi
         bumcz05S5jIq0kGoJ1MYIiA9wl64k9FywQiflZHNc+1Kv43EGzYaH8GGDj8zW9g/QItp
         dNV6z2yh4UQROeLlwLZcikqXq0IEy9P8l84zNuhTnC6wEAPh7Mnm1iBx5vZmhf9N84dz
         29urg6Wvk7EyEXq2+ktb8NsUK9Lv95o9rh2rGEqMco3imXSmem271vOoD9YerWPz4ydc
         9rhRad7CcRKyigGpqTArawoLRR+kS99qzMg740pXKFP0Jmyi7AQFkqQ1ygaDhOA6SwJb
         zpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tRakzkW9bryBlLcFYcmoInfM1jiRcffwSGQorT21Dhk=;
        b=SZ2AavMX75LCPeDUeU5pwqC76IPPRDXiYXh5vY2YLML65SGJjW5HCPnClgBfSCYOKY
         3Fb82rrd6RIHyVoVfxIok1dbeDu8Zir/GafaZyosFszk7W85i3jMXO7V+fZFmEwiHkMa
         eEk0stUFmCt66yhixTf5NcdutBoQF+2LE4BQ/pnaK5YfglLpb1f5li0UDb0DkwzrwBze
         L2vpCd9Vuzfx4fh4MPmK6knTEYU2AmgeO5K2pOQE5Y1vvOj8p4ksyquuj2fsoGez++Xc
         hmU6lIku11f8ITfqbUHNx7tWwl1bL3+gtcKvGw/yXXWW6ZrVKBpgKMKIUwRH2h6LP02w
         76AQ==
X-Gm-Message-State: AOAM530biRSFak5QivBi4uMXENH+Xxqe1YA9V7feM2Fl0nyCOPoSRBGp
        ZtkW6DxOolcV6ZLXVx2yUOr4CIwb0ksjTQ==
X-Google-Smtp-Source: ABdhPJy9GTchLsu3GzcXnf+J0PkEgNfVxaVwbiVFy9dUI+AGXxsaQBHD1tZzWMCcIYE0GYMknJch8Q==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr2611489wmg.53.1614341936601;
        Fri, 26 Feb 2021 04:18:56 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id g63sm12161618wma.40.2021.02.26.04.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 04:18:56 -0800 (PST)
Date:   Fri, 26 Feb 2021 12:18:54 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226121854.4gb5yufb23hyar73@bigthink>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi again. Going back to the start of our conversation:

On Mon, Feb 15, 2021 at 03:45:09PM +0100, Marc Kleine-Budde wrote:
> Sadly, the driver is still not in good shape...I think it will explode
> as soon as you receive a CAN frame on the rpi, as the frames are passed
> into the networking stack from the wrong context...
> 
> Maybe I'll find some time to get receive properly working.

Could you clarify what your concern is? netif_receive_skb seems to be
used in the same way in m_can.c as in rx-offload.c.

