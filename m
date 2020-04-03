Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA719D9B9
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2020 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404000AbgDCPF6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Apr 2020 11:05:58 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:50424 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403795AbgDCPF6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Apr 2020 11:05:58 -0400
Received: from midgard.internal.axentia.se (h87-96-186-165.cust.a3fiber.se [87.96.186.165])
        by mail.weplayciv.com (Postfix) with ESMTPSA id 51C6E208C713;
        Fri,  3 Apr 2020 08:05:56 -0700 (PDT)
Subject: Re: [PATCH] can: tcan4x5x: tcan4x5x_clear_interrupts: remove
 redundant if statement
To:     Dan Murphy <dmurphy@ti.com>, linux-can@vger.kernel.org
References: <20200403144602.8494-1-daniels@umanovskis.se>
 <e92799d6-06cf-6b78-0f1b-e85e4710c763@ti.com>
From:   Daniels Umanovskis <daniels@umanovskis.se>
Message-ID: <cfcf4c61-6f2d-f21e-ffc6-a4acf3ee4883@umanovskis.se>
Date:   Fri, 3 Apr 2020 17:05:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e92799d6-06cf-6b78-0f1b-e85e4710c763@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

That's more concise and arguably clearer. Sending v2.

On 2020-04-03 16:44, Dan Murphy wrote:
> How about just returning the value of tcan4x5x_write.. and remove the 
> return ret; below
>
> Dan
