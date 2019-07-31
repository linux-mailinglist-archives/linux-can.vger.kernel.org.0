Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CA7C3B9
	for <lists+linux-can@lfdr.de>; Wed, 31 Jul 2019 15:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfGaNih (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 31 Jul 2019 09:38:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:20896 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGaNih (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 31 Jul 2019 09:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1564580312;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=O7DFmiSlN27O8fjDAv0OFgpcEtxZIEu87+9g0WcDCKc=;
        b=EhWmdJ3qMTkpmcxi1sytLkhO3Fu0VeXOOXYyxjH//3/ep9S0Bi9SD3V3bhi5JeqOFd
        0dn6BQ0gGKzi28MqSSc067Ub1FZKOG4wjC+BZDN4J44ibu/ufC3+F69qp8Hf3pjOc3uu
        I9Bz6VK/VlNecv33cdWTtegnYv2mNu5WPz/JoK0+kxbo29/rZtBKOdq0KiuwotRsmZH3
        BA4yPzLtXrwaJmNaj0mQsD5nA19RCZQpFt4yeECoeSaR3+j79OCk9PfQcAlSoCN8Gj3M
        hdboPu4M96uzHv154CjzEsiitaDHGvo2FtOaQtka3Z1oknQIBFF/Zr2Sv2wM97/H5GoT
        RcyQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3DbdV+MXxt8WEBWwP2Y"
X-RZG-CLASS-ID: mo00
Received: from [172.20.10.6]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6VDcV28L
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 31 Jul 2019 15:38:31 +0200 (CEST)
Subject: Re: Disable Network Statistics - CAN
To:     Tom Prohaszka <tprohaszka@capp-tech.com>, linux-can@vger.kernel.org
References: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <e4b4d4ea-735c-fa26-3c19-369b1e19b9f7@hartkopp.net>
Date:   Wed, 31 Jul 2019 15:38:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CANRGksgbzcwt+XYNbZNrRMy=MXrT4WjXXW814=xYUgiJG+9twA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

On 31/07/2019 03.49, Tom Prohaszka wrote:
> We are using the MCP25xxfd driver.  A comment in the code indicated
> that during testing, the network statistics were disabled to achieve
> high utilization of the CAN bus.  Another comment indicated that when
> network statistics were re-enabled, a 60% decrease in throughput
> occurred.
> 
> My question is, how can we disable the network statistics for CAN, and
> if not possible for CAN, globally.

there seem to be tons of MCP25XXFD_DEBUGFS_STATS_*() macros.

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_int.c?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a#n131

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/tree/drivers/net/can/spi/mcp25xxfd/mcp25xxfd_can_debugfs.h?h=mcp25xxfd&id=9b2ffbb925a0c32ea064c0a91b6bacb33d5e877a

We had to purge all the debug stuff when mainlining the CAN subsystem 
and I wonder if this is really NEEDED.

When the driver is in mainline Linux we can assume it to work - and not 
to be debugged anymore.

Additionally the CAN_DEBUG_DEVICES Kconfig option could have been used 
to debug potential pitfalls.

IMO the debugfs stuff should be removed completely.

Best regards,
Oliver

