Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA1FD82C
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2019 09:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfKOIyj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 15 Nov 2019 03:54:39 -0500
Received: from first.geanix.com ([116.203.34.67]:59098 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOIyj (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 15 Nov 2019 03:54:39 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 32DC88EB11;
        Fri, 15 Nov 2019 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1573807905; bh=vDoNkXgqZvLWAaFRd18hbs6/7ryKWZ1VHxqRqeJphEM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V3QdC2gaauG85j1MReH2idaArv34G/vYFvF1x8AHJx/2rwycb+lV87JDvAcibJvIT
         JqLqqcfOGnfCCKQAQhaPkQzMVRtkW2A7IQx6cxGsbXGf1bX9JC+y0hMdjJkli+OFzT
         voWmwveFNj8LCJlkiczfld9SiENHg4/lgMudnt2uuBshaIrurdh1EAEHChTbEkEb55
         l9KmZ3DwG1aOQ2QTJeaq/WaZKENyFMBxV0suf5+zCsrDDw3oU/kQSz15ezfg9yo/wX
         arJ7XERWVH/YHCQo73nqqbbznmOs/NhSX8PHvgaQ0UlTq5052lrwM7oJ4wj7i03FQu
         KP0mJz/jfzTLA==
Subject: Re: [PATCH 1/3] can: flexcan: fix deadlock when using self wakeup
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20191115050032.25928-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB4618335E8A90387EDAE17F21E6700@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <986c06e6-644a-5ad4-b7e0-ce431605b626@geanix.com>
Date:   Fri, 15 Nov 2019 09:54:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4618335E8A90387EDAE17F21E6700@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on b0d531b295e6
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 15/11/2019 06.09, Joakim Zhang wrote:
> 
> Hi Sean,
> 
> I remember that you are the first one sending out the patch to fix this issue, and I NACK the patch before.
> I am so sorry for that, it can work fine after testing at my side. Could you help double check at your side for
> this patch? Both wakeup from totally suspend and wakeup from suspending?
> 
> With this patch, we can fix two problems:
> 1) fix deadlock when using self wakeup
> 2) frames out-of-order in first IRQ handler run after wakeup
> 
> Thanks a lot!
> 
> Best Regards,
> Joakim Zhang

Hi Joakim,



We are mostly listening for broadcast packages, so we haven't noticed 
frames out-of-order :-)



I have checked this series, it comes out of suspend every time :-)

/Sean

