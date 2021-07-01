Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402243B8E48
	for <lists+linux-can@lfdr.de>; Thu,  1 Jul 2021 09:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhGAHni (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 1 Jul 2021 03:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhGAHni (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 1 Jul 2021 03:43:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A880861483;
        Thu,  1 Jul 2021 07:41:06 +0000 (UTC)
Subject: Re: [PATCH v4 2/5] m68k: stmark2: update board setup
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Angelo Dureghello <angelo@kernel-space.org>
Cc:     wg@grandegger.com, geert@linux-m68k.org,
        linux-m68k@vger.kernel.org, linux-can@vger.kernel.org,
        qiangqing.zhang@nxp.com
References: <20210630230016.4099050-1-angelo@kernel-space.org>
 <20210630230016.4099050-2-angelo@kernel-space.org>
 <20210701065327.maawrm546dkfzxbx@pengutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <7effec9f-e3aa-12d1-fc91-cb7b2c4ae9ab@linux-m68k.org>
Date:   Thu, 1 Jul 2021 17:41:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701065327.maawrm546dkfzxbx@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 1/7/21 4:53 pm, Marc Kleine-Budde wrote:
> On 01.07.2021 01:00:13, Angelo Dureghello wrote:
>> Add configuration for flexcan pads.
>>
>> Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
> 
> How do we upstream the m68k changes? Should we split this series into
> m68k and CAN?

I am happy to take the m68k specific changes (patches 2 and 3)
through the m68knommu git tree.

Regards
Greg

