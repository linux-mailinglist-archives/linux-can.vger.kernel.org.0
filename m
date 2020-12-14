Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8D2D98AC
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgLNNXL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 08:23:11 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:23654 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407934AbgLNNXG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 08:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607952008;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=cWkPeApbBLMJBgYuCpxa60YQlN+etkPfRW9ALeq5HfI=;
        b=l38FNNOva2AyYwLiY2FvVV31LE6wSL33tmXWfeNyxuNiOrlMhbCd5lspxcBSyQLLwE
        rBni/9pP3kTXW0ZEuhO8Tc+uBFRz/14Wl7U0Uag1BuQdzQQH+SdAfLcgi+7ArQ+7OsM0
        e8XwQwWNQUy/bRw4gsHO/cnBR+LTxTWL9LuW1DxqX6D5Bip1gWhsjaKoQqHjWklmY6GL
        IYNszIxV94QrVGeW/MONU+6nY78Y6wgaxLFhooKahq7LVRpWpEmPAsxLkQG7We55obQa
        4yTbMNzd6i0bOndf3DWfTKudUwf94n/uyh9vN5s5jW/G6DCLm7yW/2gE869JGb4VOkZZ
        pPwg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.1 SBL|AUTH)
        with ESMTPSA id L093f2wBEDK81DB
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 14 Dec 2020 14:20:08 +0100 (CET)
Subject: Re: [can-next-rfc 1/7] can: m_can: update link to M_CAN user manual
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Sriram Dash <sriram.dash@samsung.com>, Dan Murphy <dmurphy@ti.com>,
        kernel@pengutronix.de, Sean Nyekjaer <sean@geanix.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-2-mkl@pengutronix.de>
 <3b1ef62e-f61a-7445-b890-e346781a64f9@hartkopp.net>
 <9eb66266-2211-4551-1c2b-b6493c6daac9@pengutronix.de>
 <bdb574a8-d64b-c9fc-ee65-1187208929c2@hartkopp.net>
 <0e083218-d893-7ae1-21a6-a6da5ca0540a@pengutronix.de>
 <be728d32-ff14-9d4d-9390-06ba3508650f@hartkopp.net>
 <1bc3ae96-e83f-4e7f-f473-68460c5c514d@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d273b5b6-66c8-9084-1c62-1d1dd52310d1@hartkopp.net>
Date:   Mon, 14 Dec 2020 14:20:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1bc3ae96-e83f-4e7f-f473-68460c5c514d@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.12.20 14:19, Marc Kleine-Budde wrote:
> On 12/14/20 2:11 PM, Oliver Hartkopp wrote:
>>
>>
>> On 14.12.20 11:10, Marc Kleine-Budde wrote:
>>> On 12/14/20 10:55 AM, Oliver Hartkopp wrote:
>>>> What about
>>>
>>> Sorted by preference:
>>>
>>>> https://github.com/linux-can/can-doc
>>
>> Good choice!
>>
>> Uploaded the archive of public available M_CAN user manuals that were
>> formerly hosted in my personal repo.
>>
>> https://github.com/linux-can/can-doc/tree/master/m_can
> 
> I've changed the comment to:
> 
> /* Bosch M_CAN user manual can be obtained from:
>   * https://github.com/linux-can/can-doc/tree/master/m_can
>   */

Thanks!
