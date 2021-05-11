Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7737A426
	for <lists+linux-can@lfdr.de>; Tue, 11 May 2021 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEKKBW (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 May 2021 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhEKKBU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 May 2021 06:01:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC61C061574
        for <linux-can@vger.kernel.org>; Tue, 11 May 2021 03:00:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a4so19500390wrr.2
        for <linux-can@vger.kernel.org>; Tue, 11 May 2021 03:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHcRyjFJudEPJSrraUDRrpi8/TWRtVwxp7c0qda2YU0=;
        b=LM/WaP12IVcFeqq52nScvnGrLzluEDAd57I7ZFMnuCFUEUKEZgCrsCtEI04lQSHo6Q
         jGCzKP5phDuDcVKljBRr9ORuqAF/7/K6eJL686RADRVtiGnohnRBYHMTyhmLfV4VRlgP
         Yz0LTvR2xqHhhMOkj4TlETp7RgyteWLTeDS4faDMBAJsPX+ulfe1FLeCwNTztbL+jGYk
         CGn80Ir9+F/TDNCZJAJtwrDe7pKQuN1YshNslDEL3DlpXbB2b8A/Opv7Of+mTPM0Q6j+
         aYTsWsPzjpXNaaKlAAXif4pJQJHCtLNCuJlTLmIVmUTE1Ua0ml60r4JAqBOJTUtXPYgr
         8L9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHcRyjFJudEPJSrraUDRrpi8/TWRtVwxp7c0qda2YU0=;
        b=VivkW1RUWDKVvtaurmsiX1j4l9fkzGnzOElOptKfOdSIyl0ZA37V/NY8ht1/tGHxlE
         TKPXhZX1Wc0o6PKFcfjmFypFm1iBDDpcGb7/AVsRqultoqaQ38hQ6+rq38sNkZOngMRU
         e8OJ6QQfL5mWNXDRsloS1FpTDg9m8f/6FA1QaENiDnIAORa7UvGyhDylxdeiGMPK432c
         nqThQOLTdrUWkJLv1TGz5+4hB6ILPlca/Peor1PMgd6KZxORg+dsnhMWT9DjcG2KmVkI
         0xPxK1BhX+lZuxoX8EnQmkr38loS2HvP4b6/4N4IFZ30pfXe96KbkTDncyb86ZeLIwnQ
         kWhQ==
X-Gm-Message-State: AOAM533lwcDIZ0+2wXYFJ+Fq9Ht96FMCb1z3UFuPWES2EoOhkqePsZtk
        09DaMNMjnp5BEuw5HGZngMRadg==
X-Google-Smtp-Source: ABdhPJyA0FOrTJlg9mzmRChsmtvVmGcG6QynJ5ZaDFInoEc6qDkBux0j4m8vsULFbQrJp6oF7pQUDQ==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr36625340wrt.173.1620727211331;
        Tue, 11 May 2021 03:00:11 -0700 (PDT)
Received: from bigthink (92.41.10.184.threembb.co.uk. [92.41.10.184])
        by smtp.gmail.com with ESMTPSA id k11sm27100868wrm.62.2021.05.11.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 03:00:10 -0700 (PDT)
Date:   Tue, 11 May 2021 11:00:08 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH] can: raw: fix TX CAN frames show up as RX'ed ones
Message-ID: <20210511100008.3hpqyhpavsqdvwwe@bigthink>
References: <20210510182038.1528631-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510182038.1528631-1-mkl@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, May 10, 2021 at 08:20:39PM +0200, Marc Kleine-Budde wrote:
> Fixes: e940e0895a82 ("can: skb: can_skb_set_owner(): fix ref counting if socket was closed before setting skb ownership")
> Reported-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hey Torin,
> 
> this is only compile time tested. Please give it a try.
> 
> regards,
> Marc
> 
>  drivers/net/can/dev/skb.c |  2 ++
>  include/linux/can/skb.h   | 14 +++++++++++---
>  net/can/raw.c             |  2 +-
>  3 files changed, 14 insertions(+), 4 deletions(-)

Thanks Marc, works beautifully here.

Tested-by: Torin Cooper-Bennun <torin@maxiluxsystems.com>

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

