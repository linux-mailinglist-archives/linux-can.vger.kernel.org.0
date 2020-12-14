Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0E42D9898
	for <lists+linux-can@lfdr.de>; Mon, 14 Dec 2020 14:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407773AbgLNNPs (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 14 Dec 2020 08:15:48 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:16478 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbgLNNPs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 14 Dec 2020 08:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607951516;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=liNXNa5m3nCK9vcz3VnoqbO2+XUCaDkgetZEg8qsaes=;
        b=jcD8wiTlKa0EWVjHSDTxFwYWLopIN/V5TBCmZguMlCw37d0mhz7KmmBz4ViYmbRpxh
        bXyuPb0cWdN7KIpH31ZpAOhdeUqe8mBpVPt8kxn2B8xPDQcV2srl2HU1nUq9P7qoNkmN
        kn50K9vDYYpgurA91239TB/U/FnjE7wWdiCEtuR0m9RfmasBJrCRvkQf8dzmNjlE3Htc
        XNbyXTGzNHHUVG6IrdTwOpDpPJ2L+/7Vg1GvYt2Ces8cyHAvR4oSiAsiqTQjqKHZ6T0D
        MX3lv4IM+4xra36A8Wohq1MnsJuVZktB9++QuSwUDb5j2IOK7HgjnppuZO+mIL3AjoaE
        1Qyw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.8.1 SBL|AUTH)
        with ESMTPSA id L093f2wBEDBt19i
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 14 Dec 2020 14:11:55 +0100 (CET)
Subject: Re: [can-next-rfc 1/7] can: m_can: update link to M_CAN user manual
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Dan Murphy <dmurphy@ti.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Sriram Dash <sriram.dash@samsung.com>
References: <20201212175518.139651-1-mkl@pengutronix.de>
 <20201212175518.139651-2-mkl@pengutronix.de>
 <3b1ef62e-f61a-7445-b890-e346781a64f9@hartkopp.net>
 <9eb66266-2211-4551-1c2b-b6493c6daac9@pengutronix.de>
 <bdb574a8-d64b-c9fc-ee65-1187208929c2@hartkopp.net>
 <0e083218-d893-7ae1-21a6-a6da5ca0540a@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <be728d32-ff14-9d4d-9390-06ba3508650f@hartkopp.net>
Date:   Mon, 14 Dec 2020 14:11:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <0e083218-d893-7ae1-21a6-a6da5ca0540a@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.12.20 11:10, Marc Kleine-Budde wrote:
> On 12/14/20 10:55 AM, Oliver Hartkopp wrote:
>> What about
> 
> Sorted by preference:
> 
>> https://github.com/linux-can/can-doc

Good choice!

Uploaded the archive of public available M_CAN user manuals that were 
formerly hosted in my personal repo.

https://github.com/linux-can/can-doc/tree/master/m_can

Best,
Oliver


>> https://github.com/linux-can/can-doc-archive
>> https://github.com/linux-can/can-drv-doc
> 
>> where we can create a m_can directory (as named in the kernel).
> 
> sounds good.
> 
> regards,
> Marc
> 
