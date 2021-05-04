Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C6037299C
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhEDLkH (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 07:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhEDLkD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 07:40:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED443C061574
        for <linux-can@vger.kernel.org>; Tue,  4 May 2021 04:39:07 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so1048239wmq.3
        for <linux-can@vger.kernel.org>; Tue, 04 May 2021 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxiluxsystems-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N0YguIqx55e3PLLKJ4yJwSb1DxrjpPJmPJnbjErB2/M=;
        b=FdAVQlhurVXnmWdhcSEdYzajR4mtYmImmtBTuTJFx6juZLp8Fzo2pNJME0QBQf/gXC
         wDMn9apj+l7IukBdsmKy5nRp0uwkFXuf9f6mWul13JCHmWVzGSHQExPongXNjyvjRIyB
         mq687WWvQLCpcsTfriaIcHs03ojhw9ckYa3RQl8sKnsEaHjVYd6IFOhBrkx/Ah7CymBi
         cCPKFTQvbepiu3csoEZcXtHVAjZd/Id7g/98EBUYaBkep4P3V5DDuDsoVvoWhty3jjO/
         XJosvxJryXLYtC3qasplOR8Q2sLjP/htqYKnBbwh1UADoFoYANBIdhPFrJAkrs+xMwb+
         6Nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N0YguIqx55e3PLLKJ4yJwSb1DxrjpPJmPJnbjErB2/M=;
        b=bu2cZm1sisdqVYsCUA6DtKGueLM1EaBYYOSV2GIQt69875YLGn5J+b7k97wPxWyalc
         9OsOB0vjL3ra4EnlfyLAPJF8isR59FwpsdfYugbWBhy4f99as2g4K2m8t114a39rPzQH
         6eKtCvTGoCC4XD6fTOmsTxTT7gxdw75Gaxhiim42LqV9mo7muX9eeBwbYWphKoZ2YE5w
         hdE7EB52bSN0I+Vbw5beeUP/VWjy8OLiYr+yyTt/H3Lf1PQOmdCnQ+3O4OC1eZlII3sI
         VWsFn+uaX1nxLmS4puqDU7RiS6P3cgJc4iDEkFBkYYZBZo9D0vGJoeLAG3IG1r5MhYwi
         slbA==
X-Gm-Message-State: AOAM532IRbFavx1mV0SPGzSf9a5wpT6UFt34aYFeY4STwIMpeUNa3Ks9
        w3MHepd3t+gsXoQT2nuyXrTXfQ==
X-Google-Smtp-Source: ABdhPJztXyZX02wgvPXX29PKX59c3P1m5Oi0wcP4YHxpY9JXdWzmh+K0xhDiP5iAEtAD+MEbCXNdnQ==
X-Received: by 2002:a1c:b7c4:: with SMTP id h187mr26312213wmf.178.1620128346731;
        Tue, 04 May 2021 04:39:06 -0700 (PDT)
Received: from bigthink (92.41.10.173.threembb.co.uk. [92.41.10.173])
        by smtp.gmail.com with ESMTPSA id w4sm16605062wrl.5.2021.05.04.04.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 04:39:06 -0700 (PDT)
Date:   Tue, 4 May 2021 12:39:04 +0100
From:   Torin Cooper-Bennun <torin@maxiluxsystems.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, Pankaj Sharma <pankj.sharma@samsung.com>
Subject: Re: PATCH [0/4] can: m_can: various regmask-related cleanup
Message-ID: <20210504113904.4m4fas7q47ewk77c@bigthink>
References: <20210504112035.336424-1-torin@maxiluxsystems.com>
 <20210504112756.mqidrskk4mswgxvs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504112756.mqidrskk4mswgxvs@pengutronix.de>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, May 04, 2021 at 01:27:56PM +0200, Marc Kleine-Budde wrote:
> Well done! A really nice cleanup series.
> 
> Please repost with your Signed-off-by: added.
> 
> Marc
> 
> -- 
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

Many thanks! aha, thought I was forgetting something. will do. :)

--
Regards,

Torin Cooper-Bennun
Software Engineer | maxiluxsystems.com

