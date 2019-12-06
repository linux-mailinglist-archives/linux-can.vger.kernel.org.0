Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86B115190
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLFNyK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:54:10 -0500
Received: from first.geanix.com ([116.203.34.67]:36526 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLFNyJ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 08:54:09 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id E87523BF;
        Fri,  6 Dec 2019 13:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575640441; bh=iulJdvVaSkQxRHAYkoK/a+jiOlT6gGOaO/g2hp13Aao=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Rq+NomE/fQ09HFyIA/Gfpd2ZGzpayiwYR7CO12EX38k506oRw5OwLRqBfYXn7XQaG
         bG26GVkMLYlexubeAR05RfOYluvtzpf32Xl/EbrRvovLREI4DUqfDSn7KctEBCi+ru
         Sc7Qbe1+WbUBeCoSwjk+rc29smwV+yS2BkF9zYovxGT2eCUHSVb+r8E77jbsLgHGFk
         sIeHmhYLfvIODQN/TmTtM74wUqMLXYnSARcFZQKGj/jhZuP7k59KIUz2E2uUaTbwU0
         ukKzICi65mRYYVinlcT9hX8eQlRj0zT99lah3zuStJ3j7CLE5oRke/d6xL5UmAjnlo
         IIwS5JKQxf16A==
Subject: Re: tcan4x5x
To:     Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
 <17034589-01c5-701b-e5c3-db8972c5ade0@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <e5cf55ef-57ff-c3a9-fc2f-06a3c8fb1206@geanix.com>
Date:   Fri, 6 Dec 2019 14:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <17034589-01c5-701b-e5c3-db8972c5ade0@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 8b5b6f358cc9
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 06/12/2019 13.56, Dan Murphy wrote:
> This is the INH pin.  This is what our HW guys asked for.
> 
> We probably can make this pin optional as well.

Oh the INH pin is a high voltage output, for my device 12V :-)
No really suited for a GPIO input...

So please make that optional as well

/Sean
