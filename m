Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2823B1172C4
	for <lists+linux-can@lfdr.de>; Mon,  9 Dec 2019 18:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfLIRby (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 9 Dec 2019 12:31:54 -0500
Received: from first.geanix.com ([116.203.34.67]:40318 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIRbx (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 9 Dec 2019 12:31:53 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 6FDD7443;
        Mon,  9 Dec 2019 17:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575912691; bh=uApqt4HRH3ygXqdAYgkPVGmNAqDeD495mDyOZPjvS7A=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=JslXXxyDMfTW5jaVW6qyVcYtHBe6ZbrGpgbNUShW0XofF8NrsLyiTOq0b00d6ajNY
         h2TO8+GFivu3UNp5J9klV2yjLyVcgrLlYU14EJsMUIaat3bXawGc6fvj02VkLyeLuI
         ICuNsc4P0OtbmQWuPd/2t6iHQqiRzg9I0xKvYRSNoKYo8gYgzMo75xDXmhVPqVlQcS
         hxyG477e6E1UEWnfOEUcX3HNN6zBMQHDlzFEmUjA2gzFTE5vEDFb5VhtusCsAUx6O8
         qwpUyJeRMtx+CW93fWYkdOmwAviPsbZfbg+ZAqYIP69cBYYZz56e4jSkHFKGQxbgrn
         NAbyhI1mpR3kg==
Subject: Re: [PATCH 2/2] can: m_can: tcan4x5x: reset device before register
 access
To:     Tom Prohaszka <tommy@discretecat.com>, linux-can@vger.kernel.org
References: <20191209084808.908116-1-sean@geanix.com>
 <20191209084808.908116-2-sean@geanix.com>
 <CACXUjBzBVkqk1kwtEE9SG=25P897PdG_brZwUCtS-0AxukeQiw@mail.gmail.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <1e7059c3-5db2-8446-1f9e-4503260adc82@geanix.com>
Date:   Mon, 9 Dec 2019 18:31:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CACXUjBzBVkqk1kwtEE9SG=25P897PdG_brZwUCtS-0AxukeQiw@mail.gmail.com>
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



On 09/12/2019 18.26, Tom Prohaszka wrote:
> unsubscribe linux-can
> 

Are we that bad? :-)

/Sean
