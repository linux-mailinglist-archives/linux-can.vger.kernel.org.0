Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A422F117281
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLIRJs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 12:09:48 -0500
Received: from first.geanix.com ([116.203.34.67]:39046 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfLIRJs (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 12:09:48 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 609F3406;
        Mon,  9 Dec 2019 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575911361; bh=W4Qgk8fzz4QmgJ/6CgW2JwagKaW+EHW3GH9FSSYrnFw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ku0JQXEZ/ZYNxdpQMlob+UNBHlzej56pHpIlOrIobTgV7xb0ScdyQoE0HX+wBY/43
         BPfe/i2LY9+1L02mt7GpSkFHt0So0Low+BbdIBx2MZobZo8EVIYBcqyacJaSeipmPP
         y5w89NUiXLK1+g7BgfPHKg5LyecZAHVRH+b/dmirM4RCOhwJEXB2O5P1eqziAFIj3A
         QJZDr2vGcUAYd602sDcubdEsNVnJYZm1kLPQNC+HZs1xTLFGzukiKzEqVo1EDoi2iD
         x+q6dBh0uo3vKUzhMv19gGcdga5GyIvCOCm3nfRkIpZjzr3gpWYKXp/xhvvK6tjqLi
         dwMOzMIh7RRzA==
Subject: Re: [PATCH] can: m_can: remove double clearing of clock stop request
 bit
To:     Dan Murphy <dmurphy@ti.com>, Sriram Dash <sriram.dash@samsung.com>
Cc:     martin@geanix.com, pankj.sharma@samsung.com, mkl@pengutronix.de,
        linux-can@vger.kernel.org
References: <CGME20191209091507epcas5p4f54c5c836c7fb84039ad540808820d21@epcas5p4.samsung.com>
 <20191209091449.909319-1-sean@geanix.com>
 <019301d5ae74$4d9b4b40$e8d1e1c0$@samsung.com>
 <73ad838e-d0a5-374d-4356-2c191baec883@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <28340073-0dae-f4ce-49fe-882f79f9fcfd@geanix.com>
Date:   Mon, 9 Dec 2019 18:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <73ad838e-d0a5-374d-4356-2c191baec883@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 09/12/2019 14.08, Dan Murphy wrote:
> Sean
> 
> On 12/9/19 3:37 AM, Sriram Dash wrote:
>>> From: linux-can-owner@vger.kernel.org <linux-can-
>>> owner@vger.kernel.org> On Behalf Of Sean Nyekjaer
>>> Sent: 09 December 2019 14:45
>>> Subject: [PATCH] can: m_can: remove double clearing of clock stop 
>>> request
>>> bit
>>>
>>> In m_can_config_endisable the CSA bit cleared 2 times while enabling
>>> configuration mode.
Should have been CSR here...

>>>
>>> According to the datasheet:
>>> If a Read-Modify-Write operation is performed in Standby mode a CSR = 1
>>> will be read back but a 0 should be written to it.
>>>
>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
>> Acked-by: Sriram Dash <sriram.dash@samsung.com>
> 
> I am not sure that this code is doing what you ask.
> 
> I think this commit message needs to indicate that you are removing the 
> duplicate clearing of the CSR bit
Yes see above ^^

> 
> Because the same code check and clears the CSR bit on line 379 as well.
CSR doesn't get more cleared, by clearing it two times in a row :)

The bit need to be cleared when both enabling and disabling 
configuration mode.

Dan it's quite weird I'm only receiving your replies via the mailing 
list, that's why I was kinda slow writing this answer :)

/Sean
