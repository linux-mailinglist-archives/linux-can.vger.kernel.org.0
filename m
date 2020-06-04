Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35901EDD4C
	for <lists+linux-can@lfdr.de>; Thu,  4 Jun 2020 08:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgFDGiF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 Jun 2020 02:38:05 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:11134 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgFDGiF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 Jun 2020 02:38:05 -0400
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2020 02:38:04 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1591252683;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=iYDIjqqc8Q9Y3o3HehlKUVb4sDPktGxVlK5z+tGCBwc=;
        b=N/XziD7ZyPlvy5sBZTvQALHZuUuJSZVp5+tcnGoenhRH2JN2cdqyXJw8da3GF102Ja
        dR6UCFNOrOIXXUQl7OSnXgRMWXvtbFRM8L4Fr0+BMeHgBxbaC64tLjq3AbA7hRhTFeYz
        CJf9douk8qU9EAE3uvpal+OfSHFw6jpcU7t3YfDS9NbJ5pRzO38lRWuM805GVpYde0IG
        RshcbQHQ7Em9VMikkDC2ytxNwWpe5KrlslhvIcClvtjDAiSaTOtFN49Xaofi2Vqv+xN0
        ZcBMM4oyqJ3Rb47nHByS9h4Y0rt2FL9TyZ5mQ29KusLh1nEmETfYXLyDpfHA/n4dhYaW
        WJCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGUch6lU2B"
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 46.9.1 DYNA|AUTH)
        with ESMTPSA id V08b19w546W04DJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 4 Jun 2020 08:32:00 +0200 (CEST)
Subject: Re: [PATCH] can: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200507185118.GA14022@embeddedor>
 <0420f571-2d6a-c830-2029-8da60e3c2094@hartkopp.net>
 <73903bc6-afb7-f30e-28ef-065d41c6ace6@embeddedor.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <74c08a71-afb5-aba4-2c30-c342b4a7e61f@hartkopp.net>
Date:   Thu, 4 Jun 2020 08:31:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <73903bc6-afb7-f30e-28ef-065d41c6ace6@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Gustavo,

On 04.06.20 02:58, Gustavo A. R. Silva wrote:

> Sorry for the late reply. I totally lost track of this thread. :/

NP. At least your workflow seems to work :o)

> pahole shows exactly the same output either if cf is a zero-length array or
> a flexible-array member:
> 
> $ pahole -C 'can_skb_priv' drivers/net/can/dev.o
> 
> struct can_skb_priv {
> 	int                        ifindex;              /*     0     4 */
> 	int                        skbcnt;               /*     4     4 */
> 	struct can_frame           cf[] __attribute__((__aligned__(8))); /*     8     0 */
> 
> 	/* size: 8, cachelines: 1, members: 3 */
> 	/* forced alignments: 1 */
> 	/* last cacheline: 8 bytes */
> } __attribute__((__aligned__(8)));
> 
> So, it seems everything should fine. :)

Great! Thanks for the info - and how I could have checked it on my own, too.

Best,
Oliver
