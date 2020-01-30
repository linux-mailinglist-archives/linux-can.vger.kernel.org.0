Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC14E14DC5D
	for <lists+linux-can@lfdr.de>; Thu, 30 Jan 2020 14:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgA3N6D (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 30 Jan 2020 08:58:03 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:21365 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3N6D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 30 Jan 2020 08:58:03 -0500
X-Greylist: delayed 5572 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jan 2020 08:58:03 EST
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3nXdVqK9TL132juijk="
X-RZG-CLASS-ID: mo00
Received: from [10.103.235.140]
        by smtp.strato.de (RZmta 46.1.12 AUTH)
        with ESMTPSA id g084e8w0UDvh0DM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 30 Jan 2020 14:57:43 +0100 (CET)
Subject: Re: [PATCH] bonding: do not enslave CAN devices
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com,
        dvyukov@google.com, mkl@pengutronix.de, j.vosburgh@gmail.com,
        vfalico@gmail.com, andy@greyhouse.net, davem@davemloft.net,
        linux-stable <stable@vger.kernel.org>
References: <20200130133046.2047-1-socketcan@hartkopp.net>
 <20200130134141.GA804563@bistromath.localdomain>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <81d1f033-038e-3b1a-9e14-257fad5d1983@hartkopp.net>
Date:   Thu, 30 Jan 2020 14:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200130134141.GA804563@bistromath.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 30/01/2020 14.41, Sabrina Dubroca wrote:

> 2020-01-30, 14:30:46 +0100, Oliver Hartkopp wrote:
>> Since commit 8df9ffb888c ("can: make use of preallocated can_ml_priv for per
>> device struct can_dev_rcv_lists") the device specific CAN receive filter lists
>> are stored in netdev_priv() and dev->ml_priv points to these filters.
>>
>> In the bug report Syzkaller enslaved a vxcan1 CAN device and accessed the
>> bonding device with a PF_CAN socket which lead to a crash due to an access of
>> an unhandled bond_dev->ml_priv pointer.
>>
>> Deny to enslave CAN devices by the bonding driver as the resulting bond_dev
>> pretends to be a CAN device by copying dev->type without really being one.
> 
> Does the team driver have the same problem?

Good point!

 From a first look into team_setup_by_port() in team.c I would say YES :-)

Thanks for watching out! I would suggest to wait for some more feedback 
and upstream of this fix.

Best regards,
Oliver
