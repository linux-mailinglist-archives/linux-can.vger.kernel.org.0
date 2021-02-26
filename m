Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8342F326341
	for <lists+linux-can@lfdr.de>; Fri, 26 Feb 2021 14:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhBZN1F (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 26 Feb 2021 08:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBZN1D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Feb 2021 08:27:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1B1C061756
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:26:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w7so7427016wmb.5
        for <linux-can@vger.kernel.org>; Fri, 26 Feb 2021 05:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLtiG3tadozqFqoX0KxLgvlzHJBxy3tQtnMorPQruoU=;
        b=TSeeqZXl8Vbi2dj6T7coqdZYD2H6ZwQFLS08TALUV3lUOXxiFsrrwQCJCwsCgDo6oi
         k7gv6O+wCsV705B8E44UMNN9DWn9ji6br7pc5zHkOYkYrqYdGKjCd4yCpoxh4oRGxWEE
         okKn1UAoEUWYOIU98MUpriH/DNnIB1IajvVQy8yFb5QU7ItCmQ8Uexyz0yN0VdbNDUMc
         E308cCfu/RJZJwVebMng9fR3Rc28wpraGDDqiiusbscPt6OqqjRjUxgoOGpaSXNqoDST
         qPIPShBTXlX0HfbtVLm82ga5IfbUd6VEFcqUsyJswKJviUCRWQIgbAl477sNJ2FbxByB
         GE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLtiG3tadozqFqoX0KxLgvlzHJBxy3tQtnMorPQruoU=;
        b=RzGXPA1mRKuNqIrVZO8birdjyXD4ba6oRQDR6HKYDC4IhuBbLG+PF+PBazN29F+5I+
         TegetduQaJ6/ou9uz/2oXDOOuvgNwlp+Lt6SsfEqB1ZPyggjKOXCTktFeOK0uebVD5Qk
         V4UikH68Frlr0tHVE8JS+eKueKiTCoTe/F6EHz+LNLAVRUddQBi4/Wdeq2rAIbBY73sA
         XTgB6FKZ9sSRhB4eZFoljT3J5YlUBi1RqkojAzIFvbVrQjRKhX5fLXOUT59MJaGjTDeW
         OYzBJbN4ti0C/IP6TX3oUCcq5iTjU1qtUEDId8gsiMjo22IQB+CNbQ/mKyQEeOpJYkHx
         IEvg==
X-Gm-Message-State: AOAM531eYnAHQHcdtcx6pUD+LUAW64odqlqmHlXe3GJPdsKgQo4b997q
        x0IWOycb94Yi0zU4vf4SBRZSLA==
X-Google-Smtp-Source: ABdhPJxg6LtlA0lkVaSueD98t7gEgdkEoyjRuFOGHVp7DV7P2odW1k5Tey2xO0O3zuaWqwCV72C+9Q==
X-Received: by 2002:a7b:cb98:: with SMTP id m24mr2815056wmi.15.1614345982300;
        Fri, 26 Feb 2021 05:26:22 -0800 (PST)
Received: from bigthink (94.197.200.66.threembb.co.uk. [94.197.200.66])
        by smtp.gmail.com with ESMTPSA id x13sm12499828wrt.75.2021.02.26.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:26:21 -0800 (PST)
Date:   Fri, 26 Feb 2021 13:26:20 +0000
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: can, tcan4x5x: look to merge rpi support into rpi kernel tree
Message-ID: <20210226132620.wfuvywkzmhwfmhpc@bigthink>
References: <602651f9.1c69fb81.302a5.647d@mx.google.com>
 <20210215144509.rhds7oybzat6u27w@hardanger.blackshift.org>
 <20210226121854.4gb5yufb23hyar73@bigthink>
 <7254df67-202f-ac23-c45c-fcb5172a70a3@pengutronix.de>
 <20210226123144.cwhjberqeyjctc6w@bigthink>
 <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aebafa3-6a18-7d14-b32d-e17909d3d6a8@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Feb 26, 2021 at 01:40:35PM +0100, Marc Kleine-Budde wrote:
> I think you cannot do (synchronous) SPI from NAPI (which is SoftIRQ context).

I see. I now understand why you recommend using mcp251xfd as a template
for m_can.

Am I correct in saying that rx-offload requires RX timestamps to be
available? They can be enabled in M_CAN, but the v3.3 manual states that
the internal timestamp generation (apparently only option for tcan4x5x)
cannot be used for CAN-FD.

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

