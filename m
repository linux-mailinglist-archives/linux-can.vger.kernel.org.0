Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A811514A
	for <lists+linux-can@lfdr.de>; Fri,  6 Dec 2019 14:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLFNsc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 6 Dec 2019 08:48:32 -0500
Received: from first.geanix.com ([116.203.34.67]:36284 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfLFNsc (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 6 Dec 2019 08:48:32 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id BDD513BF;
        Fri,  6 Dec 2019 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575640103; bh=o8I4Nh253ko5RDprPZPuswvIkCfAuuPbo8zzvDlS8u8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=eYalx5qGqD3S1sIfOdh4BhOqwhx5ptVGfxJR9vfwfkgzx5TPakemYPPLd/S0AFIPI
         8unYIn50z2fbEZyT/bMO6jpS8qs7HYofY1QWIKnCNl7TLO0oNGu+mMJKpsnw+V/zFz
         INPaXbAKAngGiYEcp9jZsF+wygTr9ff7tijj/qUYs1QxNqMsBK/ssMUjlkoPQxx1Vz
         H9auToiwQ+LsRJQ/++MehaSd1knLWeBSrRaz3bu7gffSHLMQCNR3UzybEFVEl4eNs2
         bep8Ay34mpwKFj33mqzyFPmNyRlkXAVRIQ84IDq1kBvIVay16ZR/k55Ar0rhce3T+U
         PgdHIShjtLJ6g==
Subject: Re: tcan4x5x
To:     Dan Murphy <dmurphy@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <c16a87a4-5021-b25f-076c-18aa7b482baf@geanix.com>
 <17034589-01c5-701b-e5c3-db8972c5ade0@ti.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5b0d7254-c9d1-085d-cbe3-023e20023c76@geanix.com>
Date:   Fri, 6 Dec 2019 14:48:29 +0100
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
> I am not seeing this requirement in the data sheet.  Maybe my data sheet 
> is out of date.
> 
> Is that 700uS out of reset?
> 

See section 8.3.8 RST Pin in tcan4550-q1.pdf :)

/Sean
