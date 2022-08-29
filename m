Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C355A56B8
	for <lists+linux-can@lfdr.de>; Tue, 30 Aug 2022 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiH2WG4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 29 Aug 2022 18:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiH2WGz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 29 Aug 2022 18:06:55 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957FA8A6C5
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 15:06:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c2so9300038plo.3
        for <linux-can@vger.kernel.org>; Mon, 29 Aug 2022 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PVgk1cYgmYdP4/z4FGNSnk6B21vheryH4WleroFD7+c=;
        b=H1qAkZGA4OVOv6X6d5+8sVRSkog8oFm3MWrQR/VztA7mi2MZAkkNCv8kA981Qq03Fx
         MUJmWhQAQRkde2/NnKvlNpZIUfiPRfurvuynlPO9SVIBUaNUcv+DBHHCwK9SBZdKgcfP
         32Hlchfx3ykLEVe0oBHty7ikUk5Ly7kAHhY3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PVgk1cYgmYdP4/z4FGNSnk6B21vheryH4WleroFD7+c=;
        b=aXFI5vM+jThcm1ulDNZPmBBNNHNIMxdsbDCptvS9e+PBLr5LaGWzS9olwX7D9+WDQ9
         uslTMgYEJYk2LyLycjBo8y5XApcRRw4Odoesq4Hm3+r4H6cHgaWQH9z9Msxnd1CeO2vD
         4D59fQmvEuWJSuGRSleM5qOobNCXarDhJa+Vfc1vg+kuU3v0aH+G1zPNPx7gZMmwSCCj
         CA5TYkuYFWzZLl0VF3lInyJiz8FEnlFuOuCKXZEDRGkwpMmmEBE1/QjbFgt1CxbdKsWB
         nPSjQPhftM4YpJzThjKXHi+fn285YdrDBPMcAFnyWzyUCiityk7bqwGhIAWyVQlmeMbn
         7PgA==
X-Gm-Message-State: ACgBeo17Ozb5MhZ2mBfWCmaCd7hLPmmXyy5x0IyfLogY3aQri5DG5hJp
        6mZENijtOUUndzR31ul39pfT/hrPm2AVew==
X-Google-Smtp-Source: AA6agR5YscpVPaUvYDy7+TR/YvEO+8Cce/NhVhMaYXtHKDHqYrGOwq2jWuhNHtLxJ3DZyjsxf7V8/g==
X-Received: by 2002:a17:90a:7343:b0:1fd:d6fc:b2f with SMTP id j3-20020a17090a734300b001fdd6fc0b2fmr6219851pjs.65.1661810812073;
        Mon, 29 Aug 2022 15:06:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10-20020a170902a38a00b0016bdeb58611sm3271966pla.112.2022.08.29.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 15:06:51 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:06:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] can: etas_es58x: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202208291506.869166F4CE@keescook>
References: <Yw00w6XRcq7B6ub6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw00w6XRcq7B6ub6@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Aug 29, 2022 at 04:50:59PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declaration in union es58x_urb_cmd with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for a flexible-array member in a union.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
