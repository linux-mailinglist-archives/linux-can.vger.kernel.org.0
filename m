Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F54113C74
	for <lists+linux-can@lfdr.de>; Thu,  5 Dec 2019 08:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbfLEHjL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 5 Dec 2019 02:39:11 -0500
Received: from first.geanix.com ([116.203.34.67]:54004 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfLEHjL (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 5 Dec 2019 02:39:11 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 914D1953E8;
        Thu,  5 Dec 2019 07:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575531290; bh=XbIajKPVT2fR30jFuGrcwHs68nEKP6G3Cuhw2nq0YFA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JdglDZs2l8DyRblENAgzqwGsMttzZOeFnixlWC/GDFP68ZWF50NsLkM3dEQgL4wGD
         5omcRdSPkjwkIg39aGRoSC2IZeckB02CJXOvRVqKo2os+PnTgiM01tS3hsiaGaZ/xS
         M71bsRzhorDBkRO4MzlkrP82lROB4lyMD8rGXutVVdRJVbpJ4W6+p83ZQh8syy8dxK
         8Q16QJ81GhOLzK9xcbUJhGjB6Sl06vZMDRd++M1/rhmJXle3sriVjdajrLlZpwLnwa
         pDi2GiwymDi5jQM7FGHOk3Ob8ifZVWwvVxK6ZI9wJ/SyutLMbqa1PqdX33FoubAJz6
         AHxAvqbbMXmww==
Subject: Re: [PATCH 2/2] net: m_can: Make wake-up gpio an optional
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20191204175112.7308-1-dmurphy@ti.com>
 <20191204175112.7308-2-dmurphy@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <b9eaa5c4-13bc-295f-dcbf-d2a846243682@geanix.com>
Date:   Thu, 5 Dec 2019 08:39:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204175112.7308-2-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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



On 04/12/2019 18.51, Dan Murphy wrote:
> The device has the ability to disable the wake-up pin option.
> The wake-up pin can be either force to GND or Vsup and does not have to
> be tied to a GPIO.  In order for the device to not use the wake-up feature
> write the register to disable the WAKE_CONFIG option.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> CC: Sean Nyekjaer <sean@geanix.com>
Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> ---


Hi Dan,

I would add tcan4x5x to the subject of this patch ->
"net: m_can: tcan4x5x Make wake-up gpio an optional"

Will be testing this during this or the next week...

/Sean
