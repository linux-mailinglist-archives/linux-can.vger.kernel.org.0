Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17A7396F91
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 10:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbhFAIwc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 04:52:32 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:30490 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhFAIwF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 04:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622537418; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p9BG81JdxrWNkxmdUMY4ynrMyWp9QrFt5hDDjZV7aBhIFJ3nhvkhHLaaS/ErA+RqQR
    c+yGqNNX8wrGjsHWao/gvTuCE4OqcRJI48rb9Sty64FxNql4ZIXfUBNeYgdQmB3qxNzf
    h/D019GL0oHGE+Fpsp9O6gVHlkPZynHyOYaeyS7ldQ3am9Kiou+MXxFHlASYc7op4jBN
    ZcestJt3tiasaM5IflErZY5FVIB1aEoLl7zhaPJqsb7rhnctlYnC1pCC1JruedqfK2gc
    BB+NW8BybR0aPslcosKkfp1glAalc+bd+YKwMDYcwPHNyr1VEA/IbN97TNoVZfkIAu4d
    ddIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622537418;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=EIpDeEnWKDbk8mlSINtPRfTUi+ajWOZlTj3R0444KFM=;
    b=kx1cZ32c8dlPN29w8vi5bWe69ePJg4O+12OA9K5FMANvx1YmC+4KtwJoPnZyZHYpZU
    xihR4jK0rjkleXA3FqE5TrJ1/ht+RKL8sLST/ZsvzxIiffRI5NgxN9v4gysYQ97dabB/
    gEdgXGyLTsC3m550tqGa94NG23a9aB4OnvCyE51kFOIJqHcnZy6PTX+RHm5Q5pjjyYbs
    QqvqGmwdfMQiRNm5mcq6ZtTqQp4SzOusXRYd9EGxl3cHMRwUBSmXzllMqJoJZ2twSJRd
    y7Vmw+VaY5w0MdrTJeTV2E6Twbu3QOF0HtUm2mAfMbADt3tkCNs395ENx4HloCxtsAD6
    pfLA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622537418;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:To:Subject:Cc:Date:From:
    Subject:Sender;
    bh=EIpDeEnWKDbk8mlSINtPRfTUi+ajWOZlTj3R0444KFM=;
    b=F4z/oTl/HEdbdE9M+CnFmA479yWPkPPYJSxYyD6T0TcYTXElVGNniB7o4k6T8ovz0+
    T84uDeiZemlxTwuNChagZk34GA05OIQ2xeDRVPPm+3685pZEq2jja0a1G5Z70+7AiJ4Z
    XRHyGoIDaEU4vyZtO0Fh/6EENKGdS0kHNzB+VS3pIaz3UQGzrFyQjb971FKHiMedXhhZ
    KgYh72srgtskBzt4ODfYXZCNrq5WaeVTuo9NrtCbIcfCnL/s6ylr1foPRMQsed5jpiC2
    V0YcNyzL7uGGOrFwefV0TuY1Rk90Uw1gQK8yS4ooX8thgu8E1Pzm0yaTvDEcRd5cHIGT
    jBvA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id L04ff0x518oIBNx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Jun 2021 10:50:18 +0200 (CEST)
Subject: Re: vxcan RX/TX/echo semantics
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20210527150759.az3lal4vnhivwhlx@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <ebaf846a-f325-80fd-f926-6ad9854bf453@hartkopp.net>
Date:   Tue, 1 Jun 2021 10:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527150759.az3lal4vnhivwhlx@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On 27.05.21 17:07, Marc Kleine-Budde wrote:

> I was wondering what the RX, TX and echo semantics on vxcan interfaces
> should be.
> 
> I have started a "cangen" in one namespace and a "candump" in other.
> 
> The "candump" in the receiving namespace shows the CAN frames as "TX"
> and in the sending namespace the CAN frames don't show up in a "candump"
> at all. Is this intentional? If so what's the idea behind this and is
> this documented?
> 
> I'm adding "cangw" to the mix and see what happens....

Yes. That is needed ...

If you take a look at slide 19 here:
https://wiki.automotivelinux.org/_media/agl-distro/agl2018-socketcan.pdf

The difference to vcan's (which are providing a local echo 
functionality) the vxcan's are more like veth's:

Providing a link between two namespaces but nothing more.

The question is if it would make sense to provide an additional local 
echo in vxcan_xmit() when sending to a vxcan?

When deriving vxcan from veth I probably had a some weird thoughts why 
that local echo could add problems. But while looking at it now, 
creating a second skb for a local echo on the side where the CAN frame 
is put into the vxcan seems applicable.

What do you think?

Best,
Oliver
