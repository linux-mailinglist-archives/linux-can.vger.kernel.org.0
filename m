Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0D7B9E5B
	for <lists+linux-can@lfdr.de>; Thu,  5 Oct 2023 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJEOEt (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Oct 2023 10:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjJEODn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Oct 2023 10:03:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD2126
        for <linux-can@vger.kernel.org>; Wed,  4 Oct 2023 19:58:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c724577e1fso3734445ad.0
        for <linux-can@vger.kernel.org>; Wed, 04 Oct 2023 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696474723; x=1697079523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kNnoNX+VycKJxCFVsIPAbCtAe5boObmTDcjKlCDp2k=;
        b=i4L/3Aj8ygTjSUp9/p9XDWPSBBKIRjWIC5psTSo5nX3ZwidzXnhiCBlczgVVI2zjpZ
         9XWh+QJWSXuMiPpDWrlgZpJl/Z8tuZxCXx3YMi3JB62A4zXJlhkRATn11k3SCHNFLDbf
         Tk89LjB5wR/1YdxTpbiNiRU0F/Rvj9JM4j2NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474723; x=1697079523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kNnoNX+VycKJxCFVsIPAbCtAe5boObmTDcjKlCDp2k=;
        b=p0JzyWco7x9QdlB9XHDNRF/n7zaW/dCE5WB3ASAb4OvkjlX4uf80Ur0Nt/a122vihF
         RE4osmNFx8UqXMRBfnXo1WrE0HfuDHjAWukxhL80uoi2g2ukptFTOVRn3yeSwIW6tuIk
         dyS7SaXGRXUiXlpiuZXcz0UXSnxHqDX0E7Se/OE/SgR392B557jWEVfLQPrvvQagMK4d
         BmXLxK5e38O09RJHtKzGtLmha+uKaKSWHY/eR4PckFnl7L9/QkZahN65Vt1BRRS7nsij
         /8G+qUqDg6h7sx63Qt1FBIhPM9Z7GvxSsYtZ05QkJDmmcYnYJapTtpPNzrXW8e2zbSmq
         XFJw==
X-Gm-Message-State: AOJu0Ywmw2ADMK2rGgM4qy/Th3t+7KPBDYNWB1gR1Dsr3QVhSM6q95+X
        HvOurEK0hbASuxVyjzomYCDMAA==
X-Google-Smtp-Source: AGHT+IEuvtkB5cCQbgCWYrRd54NAG8rv4yhh7aSFHMbN97v3p48aULxm0ARxKFDY+QpqB2XuHsjBOg==
X-Received: by 2002:a17:903:1cc:b0:1c7:2661:91e1 with SMTP id e12-20020a17090301cc00b001c7266191e1mr3864559plh.15.1696474722969;
        Wed, 04 Oct 2023 19:58:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902eaca00b001b8a85489a3sm313410pld.262.2023.10.04.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:58:42 -0700 (PDT)
Date:   Wed, 4 Oct 2023 19:58:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] can: peak_pci: replace deprecated strncpy with strscpy
Message-ID: <202310041958.12F8A261A@keescook>
References: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Oct 05, 2023 at 12:05:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required since card is already zero-initialized:
> |       card = kzalloc(sizeof(*card), GFP_KERNEL);
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, this looks like a standard direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
