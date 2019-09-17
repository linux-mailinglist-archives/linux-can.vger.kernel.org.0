Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCA1B4688
	for <lists+linux-can@lfdr.de>; Tue, 17 Sep 2019 06:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbfIQEi3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 17 Sep 2019 00:38:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36375 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390748AbfIQEi3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 17 Sep 2019 00:38:29 -0400
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1iA5Fz-0001fB-AK; Tue, 17 Sep 2019 06:38:27 +0200
Subject: Re: J1939 support
To:     Robert Schwebel <r.schwebel@pengutronix.de>,
        "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e39e2d61-66ad-d3ce-cd1e-5a2245d632a1@iot.bzh>
 <20190916214043.ozk4hivghjpuwu56@pengutronix.de>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <70f12813-8f6a-fa73-42eb-95c76dde03ad@pengutronix.de>
Date:   Tue, 17 Sep 2019 06:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190916214043.ozk4hivghjpuwu56@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 16.09.19 23:40, Robert Schwebel wrote:
> On Mon, Sep 16, 2019 at 06:41:01PM +0200, Romain Forlot [IoT.bzh] wrote:
>> We followed work within linux-can-next repository and more particularly
>> about the j1939 branches.
>>
>> They have recently been removed from the repository, is it because they will
>> be integrated in the mainline kernel ? (Not found ATM in the master branch
>> of the stable linux repository)
>>
>> Else, where could be found the recent progression on this subject ? Thanks
> 
> It is currently in net-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=9d71dd0c70099914fcd063135da3c580865e924c

and linux-next.git
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/can/j1939?h=next-20190916&id=9d71dd0c70099914fcd063135da3c580865e924c

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
