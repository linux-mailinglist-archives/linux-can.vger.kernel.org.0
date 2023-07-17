Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723C755DAF
	for <lists+linux-can@lfdr.de>; Mon, 17 Jul 2023 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjGQIBE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 17 Jul 2023 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGQIBD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 17 Jul 2023 04:01:03 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC6F11C;
        Mon, 17 Jul 2023 01:01:00 -0700 (PDT)
Received: from [134.238.80.3] (helo=[10.224.195.170])
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qLJA0-00AssG-Sg; Mon, 17 Jul 2023 09:00:48 +0100
Message-ID: <96641e09-c676-2702-149c-885002f45a64@codethink.co.uk>
Date:   Mon, 17 Jul 2023 09:00:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] Add support for Allwinner D1 CAN controllers
To:     Jookia <contact@jookia.org>, linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, linux-can@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Fabien Poussin <fabien.poussin@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
References: <20230715112523.2533742-1-contact@jookia.org>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230715112523.2533742-1-contact@jookia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 15/07/2023 12:25, Jookia wrote:
> From: John Watts <contact@jookia.org>

It would be better if you sent your sending email to be the same
as the from, I think you'd technically need a signed-off-by from
"Jookia" as well.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

