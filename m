Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9775EB402
	for <lists+linux-can@lfdr.de>; Tue, 27 Sep 2022 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIZWBY (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 26 Sep 2022 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiIZWBX (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 26 Sep 2022 18:01:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E7DB07F2
        for <linux-can@vger.kernel.org>; Mon, 26 Sep 2022 15:01:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so8279390pjh.3
        for <linux-can@vger.kernel.org>; Mon, 26 Sep 2022 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=wU3T4FjaU9qDfVJPctHKYbqwT9poMiNECQZXFxXpthw=;
        b=NpMtrDRZOXiB0xUb1TtKFQTAvPuh4asn7d0bK8R3rbFTShInim3HcHlWpa98Lk7J8e
         9878xE/E6Ib4yZnFyXBhnCE+7wCuMQ6kfgTjahcmfbxLCDNnpRMweeXz7uoCcywzIXR8
         ru37hfNCKOUgEFCCc8u29FBz/d0RxXPlz4xnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wU3T4FjaU9qDfVJPctHKYbqwT9poMiNECQZXFxXpthw=;
        b=CMzDpfL0n1iND6NxKS6CL/w1h8hQ6d712Y7xGVYighMkPdijs6xTwzm5ZLC5C8zObc
         qiLURZ9J0UvxHLCpQoAOzYYPZ+Qj53EDfjElOdEoalEvDQDJxI3bk1/U+Q5ZMI4lM2VY
         CnPbmqEnE2AEnF4WEo3HrtQrEJC9XcxprwraHB0oTFzi5uLFY4Xy0I0HcEakeD1gORGa
         oE3j9DrZfOR0tFEGIcaNLQJs8oPkexntyRfbJ9/Q1ExtSeKuNeVXqrTLe8cNMm2vH32x
         0liT4ONoPizzQhbijdBuI0CUflMlY0opYC5QcI5uRz/x4hOXBP8JizvX6ddh2AK6s5si
         HmLQ==
X-Gm-Message-State: ACrzQf1ToWXbdcyYIOjoUaHPmjNjyJ40E41HkqmXgUTaCZqLgVXkV2t/
        gVm+vEilXtanm2rv99gfpxEwdQ==
X-Google-Smtp-Source: AMsMyM7lWbAH8ThnXEDFlwVQ/98rO2TnRsqVKkIvvgMC1lr8gdwsVgpsJhLsEH1PLYkt0s8t1dKdKw==
X-Received: by 2002:a17:90b:4f4b:b0:200:876b:c1c8 with SMTP id pj11-20020a17090b4f4b00b00200876bc1c8mr966306pjb.32.1664229681755;
        Mon, 26 Sep 2022 15:01:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090a74c400b00200461cfa99sm7004676pjl.11.2022.09.26.15.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:01:21 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:01:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] can: ucan: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261501.12780DB3@keescook>
References: <YzIdHDdz30BH4SAv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdHDdz30BH4SAv@work>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Sep 26, 2022 at 04:43:56PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/214
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
