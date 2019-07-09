Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7575D63C06
	for <lists+linux-can@lfdr.de>; Tue,  9 Jul 2019 21:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGITjC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Jul 2019 15:39:02 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:24119 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfGITjC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Jul 2019 15:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562701140;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=y4PE0RTl+2sR08JLK/u1bE9+d6NObtPMmeI8Rd+kwIM=;
        b=K+qociJ8syMhqyT1k5i6nAXOIUo7he+vXwchzC0YiczXIL9Mxe/E+yi1dw8mNO2Twr
        DbLCGCaY1KyRn9Vw7gTXVuG9onHIyPYiZGzzi6GvJzAhC7f2fBCSQ/Sa4cxp94Z3ZJ2F
        hjnsDi0JR8fslz5qtGFF8oP1ViLE2j8W6oc6oUv+hFwvWGLcGeQx1Dh0ZA/nC9t6jati
        Wr47AnSRsGHqRmyjUZEeoa89YVhp2RO/GR0bW6YmXO7j1Iy+B3cd6ea3hvVE12GummZ9
        e4UP/AIg5KH9AgBV5CMbEzKjtBrFqNOYNHyZXr1vybhkcnaT34w1n7Hoc1vjo2/wEntx
        G9iA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMGXsh5kUrI"
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv69Jck2Ig
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 9 Jul 2019 21:38:46 +0200 (CEST)
Subject: Re: [PATCH v1 13/34] j1939: socket: drop sanity check for ifindex
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com, robin@protonic.nl, david@protonic.nl,
        kernel@pengutronix.de, linux-can@vger.kernel.org
References: <20190709085909.1413-1-o.rempel@pengutronix.de>
 <20190709085909.1413-13-o.rempel@pengutronix.de>
 <a680d36b-0cbd-f5a6-e3fc-786b518a62bb@hartkopp.net>
 <20190709173740.pisuzxscqad7d76w@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <60fdc826-0121-3da5-8cd9-c0d0f62654ff@hartkopp.net>
Date:   Tue, 9 Jul 2019 21:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709173740.pisuzxscqad7d76w@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 09/07/2019 19.37, Oleksij Rempel wrote:
> Hi Oliver,
> 
> On Tue, Jul 09, 2019 at 07:03:12PM +0200, Oliver Hartkopp wrote:
>> Hi Oleksij,
>>
>> the topic said what this patch does - but there's no commit message that
>> tells the reader why the check can be dropped.
>>
>> And the removed comment in the patch leaves me even more lost ...
> 
> You right. I'll update the commit message.
> 
> Current j1939 stack implementation has one priv structure per interface.
> There are no more global structures. All sockets are linked to related
> priv. The can_rx call back is also configured with appropriate priv.
> It means, we can't get an skb for different ifindex.

Thanks!

Feels much better now :-)

Best,
Oliver

