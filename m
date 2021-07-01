Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50D3B8E84
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 10:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhGAIFM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 04:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234760AbhGAIFM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 1 Jul 2021 04:05:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEBD761480;
        Thu,  1 Jul 2021 08:02:40 +0000 (UTC)
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Angelo Dureghello <angelo@kernel-space.org>, wg@grandegger.com,
        geert@linux-m68k.org, linux-m68k@vger.kernel.org,
        linux-can@vger.kernel.org, qiangqing.zhang@nxp.com
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org>
 <20210701065327.maawrm546dkfzxbx@pengutronix.de>
 <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org>
 <20210701074255.jutewhpjqxsi7bdl@pengutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <7252e8f0-7d16-4707-d091-784c27911173@linux-m68k.org>
Date:   Thu, 1 Jul 2021 18:02:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701074255.jutewhpjqxsi7bdl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 1/7/21 5:42 pm, Marc Kleine-Budde wrote:
> On 01.07.2021 17:41:04, Greg Ungerer wrote:
>>
>> On 1/7/21 4:53 pm, Marc Kleine-Budde wrote:
>>> On 01.07.2021 01:00:13, Angelo Dureghello wrote:
>>>> Add configuration for flexcan pads.
>>>>
>>>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
>>>
>>> How do we upstream the m68k changes? Should we split this series into
>>> m68k and CAN?
>>
>> I am happy to take the m68k specific changes (patches 2 and 3)
>> through the m68knommu git tree.
> 
> Make it so. \o/ I'll take the rest.

As soon as the current merge window closes I will pull them in.

Regards
Greg


