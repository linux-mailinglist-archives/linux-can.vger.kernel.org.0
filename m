Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6246BAA42F
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2019 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbfIENST (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Sep 2019 09:18:19 -0400
Received: from first.geanix.com ([116.203.34.67]:60752 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbfIENST (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 5 Sep 2019 09:18:19 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 828064F77A;
        Thu,  5 Sep 2019 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567689486; bh=uqw2IhKzhaaQEY3xZMRFUOw9w2YuraMJ6etB4+yxZJs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ml3w2efT3Emn/hXQ/8/SEyjO9ojZAHevEDeZFwq2RpUwQoqKejZda/7pY4uahpi7a
         apqCLLTVeCJRveHKP/raaBYDhFV39S0AyBe58evr2UpwLamg+zCgTRNOfgcJdDotfT
         P5AXs+m9SAhg8ta1t8EoQiCu2FrN2un3odAf18V54STEOdsB3r//8xQLouJsDywPiO
         5qgsRgLz65Ie9EgJXCkQ285sblKWsCYn/2dtfdQDbOr+UqZM1TBhRMs+GOz39jaZ9j
         B/JTtvZV7PoiK5kUVNH/DMfnASKOcq7EwrLmMCFP6WZIhTE52keok7LJg2xxeFdSKe
         ibiOsnuqAXbIA==
Subject: Re: [PATCH REPOST 1/2] can: flexcan: fix deadlock when using self
 wakeup
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
References: <20190816081749.19300-1-qiangqing.zhang@nxp.com>
 <20190816081749.19300-2-qiangqing.zhang@nxp.com>
 <dd8f5269-8403-702b-b054-e031423ffc73@geanix.com>
 <DB7PR04MB4618A1F984F2281C66959B06E6AB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <35190c5b-f8be-8784-5b4f-32a691a6cffe@geanix.com>
 <6a9bc081-334a-df91-3a23-b74a6cdd3633@geanix.com>
 <DB7PR04MB4618E527339B69AEAD46FB06E6A20@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <588ab34d-613d-ac01-7949-921140ca4543@geanix.com>
 <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <1655f342-7aaf-5e36-d141-d00eee84f3ec@geanix.com>
Date:   Thu, 5 Sep 2019 15:17:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB461868320DA0B25CC8255213E6BB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 05/09/2019 09.10, Joakim Zhang wrote:
> Hi Sean,
> 
> Could you update lastest flexcan driver using linux-can-next/flexcan and then merge below two patches from linux-can/testing?
> d0b53616716e (HEAD -> testing, origin/testing) can: flexcan: add LPSR mode support for i.MX7D
> 803eb6bad65b can: flexcan: fix deadlock when using self wakeup
> 
> Best Regards,
> Joakim Zhang

The testing branch have some UBI bugs, when suspending it crashes...
So will have to leave this, until they are resolved :-)

/Sean
