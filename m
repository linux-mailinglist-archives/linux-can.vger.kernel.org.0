Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D035E294ABF
	for <lists+linux-can@lfdr.de>; Wed, 21 Oct 2020 11:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441487AbgJUJsp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 21 Oct 2020 05:48:45 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:8898 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409073AbgJUJsp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 21 Oct 2020 05:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603273721;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JxeFaFvP1bKyNDKG2+Kk09ueT4d4L5hGA05FMoiw6zY=;
        b=lXFM/IEzV3FHzzTkLTfKAeotST/FvmEc2SVGKd8RG/FQw3jfTIKMYn/5ILIB4+awAE
        pD4RZWjUbONQQdY+bGfLM0i0X33rSBDHTsNtiZpx4STSFPO/zsSfuiBKTcUivk261O4E
        8R/+UBN/6s8BrY/Ek01g3E191AJyvw7/8xJza8fe6j2vu67rtOmPx0QVhbQlNGfg4nNd
        hz8hiNx7l4oH9JWcF66z2p8vRerYQC2d0nimWHqrMFCN3A34jPnckoid8rNrxW4r91KF
        zPbR6/8ZNIFnPc27DW3BxikR3Mcfalgl4kDlsu/hjRtHqahHHKA91kEfvL2ObyBbXeVb
        o4WQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMRppw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id D0b41cw9L9meqVH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 21 Oct 2020 11:48:40 +0200 (CEST)
Subject: Re: [net-rfc 04/16] can: dev: can_get_len(): add a helper function to
 get the correct length of Classical frames
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de,
        =?UTF-8?Q?St=c3=a9phane_Grosjean?= <s.grosjean@peak-system.com>
References: <20201019190524.1285319-1-mkl@pengutronix.de>
 <20201019190524.1285319-5-mkl@pengutronix.de>
 <fbbe1b80-c012-dc87-1eb0-4878cd08cce1@hartkopp.net>
 <ebf50f35-f093-b2c9-a27c-cef73d403efb@pengutronix.de>
 <20201020113023.102360-1-mailhol.vincent@wanadoo.fr>
 <6f869e47-9a76-3398-0b64-2d573d412f4c@hartkopp.net>
 <20201020160739.104686-1-mailhol.vincent@wanadoo.fr>
 <a9605011-2674-dc73-111c-8ebf724a13ac@hartkopp.net>
 <20201021005226.2727-1-mailhol.vincent@wanadoo.fr>
 <CAMZ6RqKFST4dcWZP_8NdDMB6GT09vhVWgN+nuMWkVovkh-EZdw@mail.gmail.com>
 <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
Message-ID: <ec145768-3efb-1abd-718b-4899f08fe302@hartkopp.net>
Date:   Wed, 21 Oct 2020 11:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2711ea6f-e1ce-c3f9-dd98-83142bd33fc9@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Answering myself ...

On 21.10.20 11:21, Oliver Hartkopp wrote:

> With CAN_CTRLMODE_RAW_DLC enabled the CAN driver would ...
> 
> - fill can_dlc and raw_dlc at reception time
> - will use raw_dlc instead of can_dlc at tx time
> - will use can_dlc if raw_dlc == 0 at tx time

To be more compatible to non raw dlc CAN frame sources the tx handling 
could also be like this:

if ((can_dlc == CAN_MAX_DLEN) &&
     (raw_dlc >= CAN_MAX_DLC && raw_dlc <= CAN_MAX_RAW_DLC))
=> use raw_dlc


