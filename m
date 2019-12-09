Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B46117733
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 21:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIUQ0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 15:16:26 -0500
Received: from first.geanix.com ([116.203.34.67]:48998 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfLIUQ0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 15:16:26 -0500
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 44769451;
        Mon,  9 Dec 2019 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575922563; bh=Jqt/5VaxgcfXSRVLY9I9uoV5fQ6rr4ATEKYtE1Dn86U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=F5+IVmS9IHxGKoKZcdf8RG+ZTZ60jIQ/xXELC6QoWKtU0GcK2iejaGxYo7HwmZ+CJ
         wqhCTbeUdbgSDG1i/sS9P1v/ZML73nnqLyaYquuRoP5J8C3icIUytcJZust6sceTFE
         r4i0E28PdgZp68X3nV0yLzROQ2A4N0SXT3MjBBakdhDlh6CrtP+4qUa1UHvdUnue7y
         AzClEJg+qr+SSWULokhRSpkMdrG6ZhkVD5z0N1tW8n+sY4TfbFuNwXDb1xwQXdBkkn
         s2wtQMpbIH7VxDgLaFqZpNZkn6ENTOG+fKtz6BT1eIuVHGYeALeh7Q4KjnSiBtFyVN
         6m6ULK7do3F3w==
Subject: Re: [PATCH v2] can: m_can: remove double clearing of clock stop
 request bit
To:     Dan Murphy <dmurphy@ti.com>, sriram.dash@samsung.com,
        pankj.sharma@samsung.com, mkl@pengutronix.de,
        linux-can@vger.kernel.org
Cc:     martin@geanix.com
References: <20191209192949.998976-1-sean@geanix.com>
 <cdf36996-376a-4755-75ff-27c441a317ad@ti.com>
 <8382275e-c878-6dd2-cd78-9f4615d299ee@geanix.com>
 <edab9b5b-ce12-632d-9c23-af5692d082c7@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <b5645be3-8203-eb65-13db-260bb7e27b11@geanix.com>
Date:   Mon, 9 Dec 2019 21:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <edab9b5b-ce12-632d-9c23-af5692d082c7@ti.com>
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



On 09/12/2019 21.10, Dan Murphy wrote:
> 
> Its only confusing because what you are changing is for the MCAN IP code 
> and is not specific to TCAN.  The change affects all devices that 
> register to the m_can framework.
> 
> Referencing the TCAN data sheet for the Bosch IP implementation is not 
> correct.
> 
> All the commit message should say is basically what the $subject says 
> because that is all it is doing.

Just posted V3 with a simpler commit msg :)

/Sean
