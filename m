Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF7117525
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 20:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLITCQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 14:02:16 -0500
Received: from first.geanix.com ([116.203.34.67]:43024 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfLITCQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 14:02:16 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 7D6B6406;
        Mon,  9 Dec 2019 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575918113; bh=qNxnOhw2ePlrxPN7xBMUpN5SX/dAbmn6oP9e+QNGTR8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XvcFXFTSZHCgSi61H5ooOjo78u1/XSkb2u7FkWB2awbrrwB+K1nfvDXObo4LSvv7L
         2TBo8cV2lG3I+mAnzrvgt0Iy8VCMQ4GCn1IY5uigIBWyag3KJfbOt6yW6fomXhIvxA
         gzzKvQSPMMvYcWInVxjmGcdYyTNnFUBoHAzu8UlxVcagrCVN8bzMxdZ2mB8mPJ+y1u
         HsBA4yrz6xagPf3JEGPF0eyEgr/Q35BxULeGfs2DnostgyDVp02mAIo8WU+O6y/MNS
         /brZOdMBxzqbgCyUg5UhPoyQ5aMcfiEGaPND5yRurIxf53hLUE0RnFIp7rg3EOK2zG
         J9W+EnTTKJThQ==
Subject: Re: [PATCH 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Murphy <dmurphy@ti.com>, linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191209084808.908116-1-sean@geanix.com>
 <20191209084808.908116-2-sean@geanix.com>
 <233a4bad-1439-3e7c-18c5-a7b5c5bb1a0c@ti.com>
 <3196f5db-6b05-6e11-764f-04506bb92149@geanix.com>
 <51897527-8015-554c-e8e7-d542d9cc1bc5@pengutronix.de>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <660b175d-9c35-ee2b-26c3-0928df76673f@geanix.com>
Date:   Mon, 9 Dec 2019 20:02:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <51897527-8015-554c-e8e7-d542d9cc1bc5@pengutronix.de>
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



On 09/12/2019 19.02, Marc Kleine-Budde wrote:
> On 12/9/19 6:14 PM, Sean Nyekjaer wrote:
>> I'm also removing the 700us delay after reset I added in the previous
>> patch, ups.
> 
> Please make all further patches based on linux-can/mater, as "can:
> m_can: tcan4x5x: add required delay after reset" is already mainline.
> 

It was based on "can:
  m_can: tcan4x5x: add required delay after reset" :-)

I'll send a V2 now

/Sean
