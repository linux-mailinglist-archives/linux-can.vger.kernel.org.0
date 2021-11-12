Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EB944EE11
	for <lists+linux-can@lfdr.de>; Fri, 12 Nov 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhKLUrM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Nov 2021 15:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbhKLUrL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 12 Nov 2021 15:47:11 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37288C061767
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 12:44:20 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so42567572edz.2
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 12:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=htlSI9PbweXay3zAqrSqMP+DpA1ClH8JSrIOkKm4ThM5VQWQeSQcQTuWqsEfU+IDbe
         QIUllEebtflPJL8Cv/ENnzIJTDRXjeJPxnccsg30WJ4yh/6GCPQx8bZfjt8NAF4Bh6Vd
         1rJPvM8EESgHfctOmZ+HPr1SV7NkIGVI9BqW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55PU7NCx+y3qp+yVH779Q0TOGJYQ+3HFYI6HIRyxT3U=;
        b=RUFjD7pH8KakuRVeNrPhA3EI0K8BLYS28y/DfoCrDmHDYyhD/fJkXmeQbsjw/w369u
         JDYdLxTTDuut7ji3OLeW4rG8lLPfU5JWoAli1dXn3pjQlqEAfN1Tdc3sizzB9T+TXPw/
         ZxmL3Bh/JxtQt1Qz2xsICfHS0w5B2RXWXdYJlqkep8kN/pWco37tkvMZTyQRR11x06F4
         MPhe7LnkkZicJVKhQRt4loHVoHBzFgrOHX+2lfD2RenZ61tn7e5DvfU8UYpy7f4dgxXJ
         NjjrTWXnLvlZVIB0AqCQ38q0zNVT5JCm9g/bwhS89+HH2cKPAchoE+mhdwUd2Bpn8P6C
         1bIQ==
X-Gm-Message-State: AOAM533lHuhKO1KiorjTNOw1aiJAUgCW+jWVzad/+0QQjCoSlCOoB5XT
        nVJOtif51ps0jIJPF4WoZ2o6DB0SVLKAX79UaWY=
X-Google-Smtp-Source: ABdhPJw8lHxmLKjvZqUFolvePOMcc3JNNDxkiy9WQz//b5s5EYSWguvvSCDgap0U4TiYSKFxeteMbQ==
X-Received: by 2002:a17:906:7632:: with SMTP id c18mr22931117ejn.104.1636749858621;
        Fri, 12 Nov 2021 12:44:18 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id sb19sm3026001ejc.120.2021.11.12.12.44.17
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 12:44:18 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id t30so17599209wra.10
        for <linux-can@vger.kernel.org>; Fri, 12 Nov 2021 12:44:17 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr22056131wrm.229.1636749857666;
 Fri, 12 Nov 2021 12:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111163301.1930617-1-kuba@kernel.org> <163667214755.13198.7575893429746378949.pr-tracker-bot@kernel.org>
 <20211111174654.3d1f83e3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com> <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNEdrLirAbHwJvmp_s2Kjjd5eV680hTZnbBT2gXK4QbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Nov 2021 12:44:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Message-ID: <CAHk-=wi=w9_TXkQF9P5KranoL_=ChVQyahjecMo1wzRTe0UtEg@mail.gmail.com>
Subject: Re: 32bit x86 build broken (was: Re: [GIT PULL] Networking for 5.16-rc1)
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, Nov 11, 2021 at 6:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>   +#include <linux/io-64-nonatomic-lo-hi.h>

I committed that fix just to have my tree build on x86-32.

If the driver later gets disabled entirely for non-64bit builds,
that's fine too, I guess. Presumably the hardware isn't relevant for
old 32-bit processors anyway.

                Linus
